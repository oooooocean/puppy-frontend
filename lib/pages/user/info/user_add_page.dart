import 'package:frontend/pages/user/info/user_base_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/models/gender.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class UserAddPage<C extends UserBaseController> extends GetView<C> with KeyboardAllocator, ThemeMixin {
  final nickNameNode = FocusNode();
  final introductionNone = FocusNode();

  UserAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(controller.title)),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.toPadding),
            child: Column(
              children: [
                Expanded(
                    child: KeyboardActions(
                        config: doneKeyboardConfig([introductionNone, nickNameNode]), child: _editContainer)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15.toPadding), child: _nextItem)
              ],
            ),
          ),
        ),
      );

  Widget get _editContainer => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _avatarItem,
          _nicknameItem,
          Padding(padding: EdgeInsets.only(top: 15.toPadding, bottom: 25.toPadding), child: _genderItem),
          _introduceItem
        ],
      );

  Widget get _avatarItem => PuppyAvatarButton(didSelected: controller.choseAvatar, defaultAvatar: controller.defaultAvatar);

  Widget get _nicknameItem => PuppyTextField(
      focusNode: nickNameNode,
      controller: controller.nicknameCtl,
      maxLength: 20,
      hintText: '毛孩子一般喊你啥?',
      onChanged: (_) => controller.update(['next']),
      textAlign: TextAlign.center);

  Widget get _introduceItem => PuppyTextField(
      focusNode: introductionNone,
      controller: controller.introductionCtl,
      maxLength: 200,
      maxLines: 4,
      onChanged: (_) => controller.update(['next']),
      hintText: '嘿, 主人, 你不想对我说点啥吗?');

  Widget get _genderItem => Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
      child: Obx(
        () => ButtonBar(
            buttonPadding: EdgeInsets.zero,
            alignment: MainAxisAlignment.spaceAround,
            children: Gender.values.map((gender) {
              final isSelected = controller.gender.value == gender;
              return OutlinedButton(
                onPressed: () => controller.choseGender(gender),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12.toPadding)),
                    side: MaterialStateProperty.all(
                        BorderSide(color: isSelected ? kOrangeColor : kBorderColor, width: 1.5))),
                child: Icon(gender == Gender.male ? Icons.man : Icons.woman,
                    color: isSelected ? kOrangeColor : Colors.grey, size: 30),
              );
            }).toList()),
      ));

  Widget get _nextItem => GetBuilder<C>(
        id: 'next',
        builder: (_) => PuppyButton(
            onPress: controller.shouldRequest ? controller.save : null,
            style: PuppyButtonStyle.style1,
            child: const Text('下一步')),
      );
}
