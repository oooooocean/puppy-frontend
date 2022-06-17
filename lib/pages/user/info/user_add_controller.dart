import 'package:flutter/cupertino.dart';
import 'package:frontend/models/gender.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/pages/user/info/user_base_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';

class UserAddController extends UserBaseController {
  UserAddController() {
    nicknameCtl = TextEditingController();
    introductionCtl = TextEditingController();
    gender = Gender.male.obs;
  }

  @override
  bool get shouldRequest => avatar != null && super.shouldRequest;

  @override
  void save() {
    final user = LaunchService.shared.user!;

    request<UserInfo>(
        api: () => uploadImages([avatar!]).then((value) => post(
            'user/${user.id}/info/',
            {
              'nickname': nicknameCtl.text,
              'introduction': introductionCtl.text,
              'avatar': value.first,
              'gender': gender.value.index
            },
            (data) => UserInfo.fromJson(data))),
        success: (userInfo) {
          user.info = userInfo;
          LaunchService.shared.updateUser(user);
          final next = LaunchService.shared.isCompletedRegisterFlow;
          next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
        });
  }
}
