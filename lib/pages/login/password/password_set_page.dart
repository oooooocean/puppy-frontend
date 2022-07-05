import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/comps/puppy_button.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/login/password/password_set_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';

class PasswordSetPage extends GetView<PasswordSetController>
    with ThemeMixin, LoadImageMixin, KeyboardAllocator {
  final passwordNode = FocusNode();
  final confirmNode = FocusNode();

  PasswordSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置密码'),
        actions: [
          TextButton(
              onPressed: () => controller.skip(),
              child: const Text('跳过',
                  style: TextStyle(color: kSecondaryTextColor)))
        ],
      ),
      body: KeyboardActions(
        disableScroll: false,
        config: doneKeyboardConfig([passwordNode, confirmNode]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.toPadding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildAssetImage('logo', width: Get.width * 0.35),
                _inputContainer,
                Column(children: [
                  _saveItem
                ])
              ]),
        ),
      ),
    );
  }

  Widget get _inputContainer => Container(
    padding: EdgeInsets.all(15.toPadding),
    decoration: const BoxDecoration(
        color: kShapeColor,
        borderRadius: BorderRadius.all(Radius.circular(5))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [_passwordItem, _confirmItem],
    ),
  );

  Widget get _passwordItem => TextField(
    focusNode: passwordNode,
    controller: controller.pwdCtl,
    keyboardType: TextInputType.visiblePassword,
    decoration: const InputDecoration(hintText: '至少8个字符，且包含数字和字母👇'),
    onChanged: (_) => controller.saveEnable.value = controller.shouldSavePassword,
  );

  Widget get _confirmItem => TextField(
    controller: controller.confirmCtl,
    focusNode: confirmNode,
    keyboardType: TextInputType.visiblePassword,
    decoration: const InputDecoration(hintText: '再次确认👇'),
    onChanged: (_) => controller.saveEnable.value = controller.shouldSavePassword,
  );

  Widget get _saveItem => Obx(
        () => PuppyButton(
        onPressed:
        controller.saveEnable.value ? controller.save() : null,
        style: PuppyButtonStyle.style1,
        buttonStyle: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(Get.width, 44))),
        child: const Text('保存密码',
            style: TextStyle(
                fontSize: kButtonFont, fontWeight: FontWeight.w600))),
  );
}
