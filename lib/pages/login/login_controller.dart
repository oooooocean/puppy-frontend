import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:frontend/components/mixins/validator.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';

/// 世之奇伟、瑰怪，非常之观，常在于险远，而人之所罕至焉，故非有志者不能至也。
/// 宠物星球 冲冲冲!

enum LoginStyle {
  code,
  password;

  String get url {
    switch (this) {
      case LoginStyle.password:
        return 'user/login_password/';
      case LoginStyle.code:
        return 'user/login/';
    }
  }

  Map<String, String> parma(String phone, String another) {
    switch (this) {
      case LoginStyle.password:
        return {'phone': phone, 'password': another};
      case LoginStyle.code:
        return {'phone': phone, 'code': another};
    }
  }
}

mixin LoginServerMixin on NetMixin {
  login(LoginStyle style, Tuple2<String, String> value,
      ValueSetter<Tuple2<String, LoginUser>> success) {
    request<Tuple2<String, LoginUser>>(
        api: () => post(style.url, style.parma(value.first, value.second),
            (data) => Tuple2(data['token'], LoginUser.fromJson(data['user']))),
        success: success);
  }
}

class LoginController extends GetxController with NetMixin, LoginServerMixin {
  final phoneCtl = TextEditingController();
  final codeCtl = TextEditingController();
  final pwdCtl = TextEditingController();
  final codeCheckLength = 6;
  final countDown = 60;

  /// 是否选择同意用户协议
  var selectedClause = true.obs;

  /// 是否可登录
  var loginEnable = false.obs;

  /// 是否可获取验证码
  var codeEnable = false.obs;

  /// 验证码倒计时
  var codeCounter = '获取验证码'.obs;

  /// 验证码定时器
  Timer? timer;

  var loginStyle = LoginStyle.code.obs;

  bool get shouldLogin {
    switch (loginStyle.value) {
      case LoginStyle.code:
        return codeCtl.text.length == codeCheckLength &&
            Validator.phone.verify(phoneCtl.text) &&
            selectedClause.value;
      case LoginStyle.password:
        return Validator.password.verify(pwdCtl.text) &&
            Validator.phone.verify(phoneCtl.text) &&
            selectedClause.value;
    }
  }

  bool get shouldFetchCode =>
      Validator.phone.verify(phoneCtl.text) && !(timer?.isActive ?? false);

  Tuple2<String, String> get valueMap {
    switch (loginStyle.value) {
      case LoginStyle.code:
        return Tuple2(phoneCtl.text, codeCtl.text);
      case LoginStyle.password:
        return Tuple2(phoneCtl.text, pwdCtl.text);
    }
  }

  void switchLoginPageState() {
    loginStyle.value = loginStyle.value == LoginStyle.code
        ? LoginStyle.password
        : LoginStyle.code;
    loginEnable.value = shouldLogin;
    codeEnable.value = shouldFetchCode;
  }

  onShouldLogin(_)  {
    loginEnable.value = shouldLogin;
    codeEnable.value = shouldFetchCode;
  }

  fetchCode() {
    timer?.cancel();
    codeEnable.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (t.tick == countDown) {
        codeCounter.value = '获取验证码';
        timer?.cancel();
        codeEnable.value = true;
        return;
      }
      codeCounter.value = '${countDown - t.tick}s';
    });
  }

  onLogin() {
    success(Tuple2<String, LoginUser> result) {
      LaunchService.shared.login(result.second, result.first);
      final next = LaunchService.shared.currentRegisterFlow?.route;
      next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
    }

    login(loginStyle.value, valueMap, success);
  }

  loginWithAppleId() {}

  loginWithWeChat() {}
}
