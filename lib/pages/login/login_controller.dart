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

class LoginController extends GetxController with NetMixin {
  final phoneCtl = TextEditingController();
  final codeCtl = TextEditingController();

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

  bool get shouldLogin => codeCtl.text.length == 6 && Validator.phone.verify(phoneCtl.text) && selectedClause.value;

  bool get shouldFetchCode => Validator.phone.verify(phoneCtl.text) && !(timer?.isActive ?? false);

  fetchCode() {
    timer?.cancel();
    codeEnable.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
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
    success(Tuple2<String, User> result) {
      LaunchService.shared.login(result.second, result.first);
      final next = LaunchService.shared.isCompletedRegisterFlow;
      next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
    }

    request<Tuple2<String, User>>(
        api: () => post('user/login/', {'phone': phoneCtl.text, 'code': '123456'}, (data) {
              final token = data['token'];
              final user = User.fromJson(data['user']);
              return Tuple2(token, user);
            }),
        success: success);
  }

  loginWithAppleId() {}

  loginWithWeChat() {}
}
