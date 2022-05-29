import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/comps/puppy_button.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/user/info/user_info_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';

class UserInfoPage extends GetView<UserInfoController> with KeyboardAllocator, ThemeMixin {
  final nickNameNode = FocusNode();
  final introductionNone = FocusNode();

  UserInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('个人资料')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.toPadding),
          child: Column(
            children: [
              Expanded(
                child: KeyboardActions (
                  config: doneKeyboardConfig([introductionNone, nickNameNode]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _avatarItem,
                      _nicknameItem,
                      Padding(padding: EdgeInsets.only(top: 15.toPadding, bottom: 25.toPadding), child: _genderItem),
                      _introduceItem
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 15.toPadding), child: _nextItem)
            ],
          ),
        ),
      ));

  Widget get _avatarItem => Column(
        children: [
          OutlinedButton(
            onPressed: controller.choseAvatar,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              side: MaterialStateProperty.all(BorderSide(color: borderColor, width: 3)),
            ),
            child: GetBuilder<UserInfoController>(
              id: 'avatar',
              builder: (_) => _avatar,
            ),
          ),
          SizedBox(height: 10.toPadding),
          Text('点击更换头像', style: TextStyle(fontSize: 14, color: orangeColor)),
        ],
      );

  Widget get _avatar => controller.avatar == null
      ? const Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(Icons.camera_alt_rounded, size: 40, color: Colors.white),
        )
      : ClipOval(
          child: Image(image: AssetEntityImageProvider(controller.avatar!), width: 80, height: 80, fit: BoxFit.cover));

  Widget get _nicknameItem => TextField(
        focusNode: nickNameNode,
        controller: controller.nicknameCtl,
        maxLength: 20,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
        onChanged: (_) => controller.update(['next']),
        decoration: InputDecoration(
            hintText: '毛孩子一般喊你啥?',
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: borderColor, width: 1)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1))),
      );

  Widget get _genderItem => Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: Gender.values.map((gender) {
              final color = controller.gender.value == gender ? orangeColor : Colors.grey;
              return OutlinedButton(
                onPressed: () => controller.choseGender(gender),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    side: MaterialStateProperty.all(BorderSide(color: color, width: 1.5)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12.toPadding))),
                child: Icon(gender == Gender.male ? Icons.man : Icons.woman, color: color),
              );
            }).toList(),
          ),
        ),
      );

  Widget get _introduceItem => TextField(
        focusNode: introductionNone,
        controller: controller.introductionCtl,
        maxLength: 200,
        maxLines: 4,
        style: const TextStyle(color: Colors.white),
        onChanged: (_) => controller.update(['next']),
        decoration: InputDecoration(
            hintText: '嘿, 主人, 你不想对我说点啥吗?',
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: 1)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1))),
      );

  Widget get _nextItem => GetBuilder<UserInfoController>(
      id: 'next',
      builder: (_) {
        final enable = controller.shouldRequest() == null;
        return PuppyButton(
            onPress: enable ? controller.save : null,
            style: PuppyButtonStyle.style1,
            child: const Text('下一步'));
      });
}
