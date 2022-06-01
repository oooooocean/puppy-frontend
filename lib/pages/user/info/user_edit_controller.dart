import 'package:flutter/cupertino.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/pages/user/info/user_base_controller.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:frontend/services/qiniu_service.dart';
import 'package:get/get.dart';

class UserEditController extends UserBaseController {
  UserInfo get userInfo => LaunchService.shared.user!.info!;

  UserEditController() {
    gender = userInfo.gender.obs;
    nicknameCtl = TextEditingController(text: userInfo.nickname);
    introductionCtl = TextEditingController(text: userInfo.introduction);
  }

  @override
  void save() {
    Future<UserInfo> api;
    final user = LaunchService.shared.user!;
    if (avatar != null) {
      api = uploadImages([avatar!])
          .then((value) => {
                'nickname': nicknameCtl.text,
                'introduction': introductionCtl.text,
                'avatar': value.first,
                'gender': gender.value.index
              })
          .then((params) => patch('user/${user.id}/info/', params, (data) => UserInfo.fromJson(data)));
    } else {
      api = patch(
          'user/${user.id}/info/',
          {'nickname': nicknameCtl.text, 'introduction': introductionCtl.text, 'gender': gender.value.index},
          (data) => UserInfo.fromJson(data));
    }

    request<UserInfo>(
        api: api,
        success: (userInfo) {
          user.info = userInfo;
          LaunchService.shared.updateUser(user);
        });
  }

  @override
  String? get defaultAvatar => QiniuService.shared.fetchCustomImageUrl(key: userInfo.avatar, width: 80, height: 80);
}
