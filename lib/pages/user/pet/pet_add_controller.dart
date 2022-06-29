import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:frontend/models/gender.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PetAddController extends GetxController with NetMixin, StateMixin<List<PetCategory>> {
  final nicknameCtl = TextEditingController();
  final introductionCtl = TextEditingController();

  AssetEntity? avatar;
  var gender = Gender.male.obs;
  DateTime? birthday;
  PetExplicitCategory? category;

  @override
  bool get shouldRequest => nicknameCtl.text.isNotEmpty && avatar != null && birthday != null && category != null;

  save() {
    final user = LaunchService.shared.user;
    assert(user != null, '必须登录');

    request(
        api: () => uploadImages([avatar!]).then((value) => post(
            'user/${user!.id}/pets/',
            {
              'nickname': nicknameCtl.text,
              'introduction': introductionCtl.text,
              'avatar': value.first.key,
              "intrinsic": {
                "category": category!.category.id,
                "sub_category": category!.subCategory.id,
                "gender": gender.value.index,
                "birthday": birthday!.toUtc().toIso8601String()
              }
            },
            (data) => data)),
        success: (_) {
          user?.petCount += 1;
          LaunchService.shared.updateUser(user!);
          Get.offAllNamed(AppRoutes.scaffold);
        });
  }

  /// 选择头像
  choseAvatar(AssetEntity assetEntity) {
    avatar = assetEntity;
    update(['next']);
  }

  /// 选择性别
  choseGender(Gender gender) {
    if (this.gender.value == gender) return;
    this.gender.value = gender;
    update(['next']);
  }

  /// 选择生日
  choseBirthday() {
    final start = DateTime.now().subtract(const Duration(days: 30));
    DatePicker.showDatePicker(Get.context!, maxTime: DateTime.now(), currentTime: start, onConfirm: (dateTime) {
      birthday = dateTime;
      update(['birthday', 'id']);
    }, locale: LocaleType.zh);
  }

  /// 选择类别
  chosePetCategory() async {
    final result = await Get.bottomSheet<PetCategory>(
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 设置最小的弹出
          children: state!
              .map((e) =>
                  ListTile(title: Text(e.name), onTap: () => Get.back(result: e)))
              .toList(),
        ),
      ),
      backgroundColor: Colors.white
    );
    if (result == null) return;

    PetExplicitCategory? category =
        await Get.toNamed(AppRoutes.petCategory, arguments: result)
            as PetExplicitCategory?;
    if (category == null) return;

    this.category = category;
    update(['next', 'category']);
  }

  @override
  void onReady() {
    change(null, status: RxStatus.loading());
    get('configuration/pet/', (data) => (data as List<dynamic>).map((e) => PetCategory.fromJson(e)).toList())
        .then((value) => change(value, status: RxStatus.success()))
        .catchError((error) => change(null, status: RxStatus.error(error.toString())));
    super.onReady();
  }
}
