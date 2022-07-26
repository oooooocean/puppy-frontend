import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/components/mixins/validator.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:frontend/pages/login/launch_service_controller.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';

enum PasswordStyle {
  set, reset;

  String get url {
    final user = LaunchService.shared.user;
    switch(this) {
      case PasswordStyle.set:
        return 'user/${user!.id}/password/';
      case PasswordStyle.reset:
        return 'user/${user!.id}/password/reset/';
    }
  }

  Map<String,String> parma(String newPwd, [String oldPwd = '']) {
    switch(this) {
      case PasswordStyle.reset:
        return {"new": newPwd, 'old': oldPwd};
      case PasswordStyle.set:
        return {'password': newPwd};
    }
  }

}

mixin PasswordServerMixin on NetMixin {
  password(PasswordStyle style, Tuple2<String, String> value,
      ValueSetter<bool> success) {
    request<bool>(
        api: () => post(style.url, style.parma(value.first, value.second),
                (data) => true),
        success: success);
  }
}

class PasswordController extends GetxController with NetMixin, PasswordServerMixin {
  final PasswordStyle passwordStyle;

  PasswordController(this.passwordStyle);

  final pwdCtl1 = TextEditingController();
  final pwdCtl2 = TextEditingController();
  final fromSettings = Get.previousRoute.isNotEmpty && (Get.previousRoute != AppRoutes.launchServiceFlow);

  /// 是否可保存
  var saveEnable = false.obs;

  bool get shouldResetPassword =>
      pwdCtl1.text != pwdCtl2.text &&
          Validator.password.verify(pwdCtl1.text) &&
          Validator.password.verify(pwdCtl2.text);

  bool get shouldSavePassword => pwdCtl1.text == pwdCtl2.text && Validator.password.verify(pwdCtl1.text);

  Tuple2<String, String> get _valueMap {
    switch (passwordStyle) {
      case PasswordStyle.set:
        return Tuple2(pwdCtl1.text, '');
      case PasswordStyle.reset:
        return Tuple2(pwdCtl2.text, pwdCtl1.text);
    }
  }

  LaunchServiceController get launchServiceCtl => Get.find<LaunchServiceController>();

  _success(_) {
    switch (passwordStyle) {
    case PasswordStyle.set:
      EasyLoading.showSuccess("设置成功");
      if (fromSettings) {
        Get.back();
        return;
      }
      // TODO: 继续完善
      final next = LaunchServiceFlow.passwordSet.nextRoute;
      next != null ? launchServiceCtl.stepContinue() : Get.offAllNamed(AppRoutes.scaffold);
      break;
    case PasswordStyle.reset:
      EasyLoading.showSuccess("重置成功");
      Get.back();
      break;
    }
  }

  skip() {
    final next = LaunchServiceFlow.passwordSet.nextRoute;
    next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
  }

  save() {
    final user = LaunchService.shared.user;
    assert(user != null, '必须登录');
    password(passwordStyle, _valueMap, _success);
  }
}
