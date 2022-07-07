import 'package:flutter/cupertino.dart';
import 'package:frontend/components/mixins/validator.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';

class PasswordSetController extends GetxController with NetMixin {
  final pwdCtl = TextEditingController();
  final confirmCtl = TextEditingController();

  /// 是否可保存
  var saveEnable = false.obs;

  bool get shouldSavePassword =>
      pwdCtl.text == confirmCtl.text && Validator.password.verify(pwdCtl.text);

  skip() {
    final next = LaunchService.shared.isCompletedRegisterFlow;
    next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
  }

  save() {
    final user = LaunchService.shared.user;
    assert(user != null, '必须登录');
    success() {
      final next = LaunchService.shared.isCompletedRegisterFlow;
      next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
    }

    request<void>(
        api: () => post(
            'user/${user!.id}/password', {'password': pwdCtl.text}, (data) {}),
        success: success());
  }
}
