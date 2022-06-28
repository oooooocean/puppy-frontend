import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/gender.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';
import 'package:frontend/components/extension/date_extension.dart';

// ignore: implementation_imports
import 'package:flutter_easyloading/src/widgets/indicator.dart' as es;
import 'package:keyboard_actions/keyboard_actions.dart';

class PetAddPage extends GetView<PetAddController>
    with KeyboardAllocator, ThemeMixin {
  final nickNameNode = FocusNode();
  final introductionNone = FocusNode();

  PetAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加宠物'),
        actions: [
          TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.scaffold),
              child: const Text('跳过',
                  style: TextStyle(color: kSecondaryTextColor)))
        ],
      ),
      body: controller.obx((_) => _body,
          onLoading: const Center(child: es.LoadingIndicator()),
          onError: (_) => Text(_ ?? '')),
    );
  }

  Widget get _body => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.toPadding),
          child: Column(
            children: [
              Divider(color: kBackgroundColor, height: 25.toPadding, thickness: 10.toPadding),
              Expanded(
                  child: KeyboardActions(
                      config:
                          doneKeyboardConfig([nickNameNode, introductionNone]),
                      disableScroll: true,
                      child: ListView(children: [
                        _avatarItem,
                        _nicknameItem,
                        Padding(
                            padding: EdgeInsets.only(
                                top: 15.toPadding, bottom: 25.toPadding),
                            child: _intrinsicWidgets),
                        _introduceItem
                      ]))),
              _nextItem
            ],
          ),
        ),
      );

  Widget get _avatarItem =>
      PuppyAvatarButton(didSelected: controller.choseAvatar);

  Widget get _nicknameItem => PuppyTextField(
      focusNode: nickNameNode,
      controller: controller.nicknameCtl,
      maxLength: 20,
      hintText: '平时你喊我啥?',
      onChanged: (_) => controller.update(['next']),
      textAlign: TextAlign.center);

  Widget get _intrinsicWidgets {
    return Container(
      padding: EdgeInsets.all(8.toPadding),
      decoration: const BoxDecoration(
          color: kShapeColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Row(children: [const Text('性别'), Expanded(child: _genderItem)]),
          const Divider(color: Colors.white),
          _categoryItem,
          const Divider(color: Colors.white, height: 5),
          _birthdayItem
        ],
      ),
    );
  }

  Widget get _genderItem => Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: Gender.values.map((gender) {
        final isSelected = controller.gender.value == gender;
        return Padding(
          padding: EdgeInsets.only(left: 10.toPadding),
          child: OutlinedButton(
              style: ButtonStyle(
                  side: MaterialStateProperty.all(BorderSide(
                      color: isSelected ? kOrangeColor : kBorderColor)),
                  foregroundColor: MaterialStateProperty.all(
                      isSelected ? kOrangeColor : kSecondaryTextColor),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  visualDensity: VisualDensity.compact),
              onPressed: () => controller.choseGender(gender),
              child: Text(gender == Gender.male ? '男宝' : '女宝')),
        );
      }).toList()));

  Widget get _categoryItem => GetBuilder<PetAddController>(
      id: "category",
      builder: (_) => TextButton(
            onPressed: controller.chosePetCategory,
            child: Row(children: [
              const Text('类别'),
              Expanded(
                  child: Text(
                controller.category?.subCategory.name ?? '点击选择',
                textAlign: TextAlign.end,
                style: const TextStyle(color: kSecondaryTextColor),
              )),
              Icon(Icons.chevron_right, color: kGreyColor)
            ]),
          ));

  Widget get _birthdayItem => GetBuilder<PetAddController>(
        id: 'birthday',
        builder: (_) => PuppyActionButton(
            leading: const Text('生日'),
            onPressed: controller.choseBirthday,
            value: controller.birthday?.yyyymmdd),
      );

  Widget get _introduceItem => PuppyTextField(
      focusNode: introductionNone,
      controller: controller.introductionCtl,
      maxLength: 200,
      maxLines: 4,
      onChanged: (_) => controller.update(['next']),
      hintText: '嘿, 特点, 个性, 习惯什么的, 写在这里👇');

  Widget get _nextItem => GetBuilder<PetAddController>(
        id: 'next',
        builder: (_) => PuppyButton(
            onPressed: controller.shouldRequest ? controller.save : null,
            style: PuppyButtonStyle.style1,
            child: const Text('下一步')),
      );
}
