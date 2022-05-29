import 'package:flutter/cupertino.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UserInfoController extends GetxController with NetMixin {
  final nicknameCtl = TextEditingController();
  final introductionCtl = TextEditingController();

  AssetEntity? avatar;
  var nickname = ''.obs;
  var introduction = ''.obs;
  var gender = Gender.male.obs;

  @override
  String? shouldRequest() => (avatar != null && nicknameCtl.text.isNotEmpty) ? null : '请完善资料';

  save() {}

  void choseAvatar() async {
    final config = AssetPickerConfig(
        selectedAssets: avatar != null ? [avatar!] : null, maxAssets: 1, requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    avatar = results.first;
    update(['avatar', 'next']);
  }

  void choseGender(Gender gender) {
    if (this.gender.value == gender) return;
    this.gender.value = gender;
    update(['next']);
  }
}
