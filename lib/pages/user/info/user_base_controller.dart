import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/models/gender.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

abstract class UserBaseController extends GetxController with NetMixin {
  late TextEditingController nicknameCtl;
  late TextEditingController introductionCtl;

  AssetEntity? avatar;
  late Rx<Gender> gender;

  @override
  bool get shouldRequest => nicknameCtl.text.isNotEmpty && introductionCtl.text.isNotEmpty;

  void choseAvatar(AssetEntity assetEntity) {
    avatar = assetEntity;
    update(['next']);
  }

  void choseGender(Gender gender) {
    if (this.gender.value == gender) return;
    this.gender.value = gender;
    update(['next']);
  }

  void save() => throw UnimplementedError('子类实现');

  String? get defaultAvatar => null;

  String get title => '铲屎官信息';
}
