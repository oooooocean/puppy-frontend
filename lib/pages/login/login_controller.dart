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

enum LoginStyle { code, password }

class LoginController extends GetxController with NetMixin {
  final phoneCtl = TextEditingController();
  final codeCtl = TextEditingController();
  final pwdCtl = TextEditingController();

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
        //TODO: 魔法数字
        return codeCtl.text.length == 6 && Validator.phone.verify(phoneCtl.text) && selectedClause.value;
      case LoginStyle.password:
        return Validator.password.verify(pwdCtl.text) && Validator.phone.verify(phoneCtl.text) && selectedClause.value;
    }
  }

  bool get shouldFetchCode => Validator.phone.verify(phoneCtl.text) && !(timer?.isActive ?? false);

  void switchLoginPageState(LoginStyle state) {
    loginStyle.value = state;
    loginEnable.value = shouldLogin;
  }

  fetchCode() {
    timer?.cancel();
    codeEnable.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      //TODO: 验证码
      if (t.tick == 10) {
        codeCounter.value = '获取验证码';
        timer?.cancel();
        codeEnable.value = true;
        return;
      }
      codeCounter.value = '${60 - t.tick}s';
    });
  }

  login() {
    //TODO: 1. 应该放到注册流程里去 2. 解构
    success(Tuple2<String, LoginUser> result) {
      LaunchService.shared.login(result.second, result.first);
      if (result.second.hasPassword == false) {
        return Get.toNamed(AppRoutes.loginSetPassword);
      }
      final next = LaunchService.shared.isCompletedRegisterFlow;
      next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
    }

    if (LoginStyle.password == loginStyle.value) {
      request<Tuple2<String, LoginUser>>(
          api: () => post('user/login_password/', {'phone': phoneCtl.text, 'password': pwdCtl.text}, (data) {
                final token = data['token'];
                final user = LoginUser.fromJson(data['user']);
                return Tuple2(token, user);
              }),
          success: success);
      return;
    }
    request<Tuple2<String, LoginUser>>(
        api: () => post('user/login/', {'phone': phoneCtl.text, 'code': codeCtl.text}, (data) {
              final token = data['token'];
              final user = LoginUser.fromJson(data['user']);
              return Tuple2(token, user);
            }),
        success: success);
  }

  loginWithAppleId() {}

  loginWithWeChat() {}
}
