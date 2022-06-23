import 'package:flutter/cupertino.dart';
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
  bool get shouldRequest => nicknameCtl.text.isNotEmpty && avatar != null && birthday != null;

  save() {
    final user = LaunchService.shared.user;
    assert(user != null, '必须登录');

    request(
        api: () => uploadImages([avatar!]).then((value) => post(
            'user/${user!.id}/pets/',
            {
              'nickname': nicknameCtl.text,
              'introduction': introductionCtl.text,
              'avatar': value.first,
              "intrinsic": {
                "category": 0,
                "sub_category": 0,
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

  skip() {
    Get.offAllNamed(AppRoutes.scaffold);
  }

  choseAvatar(AssetEntity assetEntity) {
    avatar = assetEntity;
    update(['next']);
  }

  choseGender(Gender gender) {
    if (this.gender.value == gender) return;
    this.gender.value = gender;
    update(['next']);
  }

  choseBirthday() {
    final start = DateTime.now().subtract(const Duration(days: 30));
    DatePicker.showDatePicker(Get.context!, maxTime: DateTime.now(), currentTime: start, onConfirm: (dateTime) {
      birthday = dateTime;
      update(['birthday', 'id']);
    }, locale: LocaleType.zh);
  }

  choseCategory(PetExplicitCategory category) {
    assert(category.isValid, '子类和父类不匹配');
    if (this.category == category) return;
    this.category = category;
    update(['next']);
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
