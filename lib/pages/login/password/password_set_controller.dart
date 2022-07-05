import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:frontend/components/mixins/validator.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';

class PasswordSetController extends GetxController with NetMixin {
  final pwdCtl = TextEditingController();
  final confirmCtl = TextEditingController();

  /// 是否可保存
  var saveEnable = false.obs;

  bool get shouldSavePassword =>
      pwdCtl.text == confirmCtl.text &&
      Validator.password.verify(pwdCtl.text);

  skip() {
    final next = LaunchService.shared.isCompletedRegisterFlow;
    next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
  }

  save() {
    // success(Tuple2<String, User> result) {
    //   LaunchService.shared.login(result.second, result.first);
    //   final next = LaunchService.shared.isCompletedRegisterFlow;
    //   next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
    // }
    // request<Tuple2<String, User>>(
    //     api: () =>
    //         post('user/login/', {'phone': pwdCtl.text, 'code': confirmCtl.text},
    //                 (data) {
    //               final token = data['token'];
    //               final user = User.fromJson(data['user']);
    //               return Tuple2(token, user);
    //             }),
    //     success: success);
  }
}
