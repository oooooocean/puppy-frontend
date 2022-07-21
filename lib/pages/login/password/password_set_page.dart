import 'package:flutter/material.dart';
import 'package:frontend/components/comps/puppy_button.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/login/password/password_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';

class PasswordSetPage extends GetView<PasswordController> with ThemeMixin, LoadImageMixin, KeyboardAllocator {
  final passwordNode = FocusNode();
  final confirmNode = FocusNode();

  PasswordSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: WillPopScope(
        child: _body,
        onWillPop: () async => controller.fromOther,
      ),
    );
  }

  AppBar get _appBar => AppBar(
      automaticallyImplyLeading: controller.fromOther,
      title: const Text('设置密码'),
      actions: controller.fromOther
          ? null
          : [
              TextButton(
                  onPressed: controller.skip, child: const Text('跳过', style: TextStyle(color: kSecondaryTextColor)))
            ],
    );

  Widget get _body => KeyboardActions(
        disableScroll: false,
        config: doneKeyboardConfig([passwordNode, confirmNode]),
        child: Column(children: [
          _inputContainer,
          _saveItem
        ]),
      );

  Widget get _inputContainer => Container(
        padding: EdgeInsets.all(15.toPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_passwordItem, _confirmItem],
        ),
      );

  Widget get _passwordItem => TextField(
        focusNode: passwordNode,
        controller: controller.pwdCtl1,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(hintText: '至少8个字符，且包含数字和字母👇'),
        onChanged: (_) => controller.saveEnable.value = controller.shouldSavePassword,
      );

  Widget get _confirmItem => TextField(
        controller: controller.pwdCtl2,
        focusNode: confirmNode,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: const InputDecoration(hintText: '再次确认👇'),
        onChanged: (_) => controller.saveEnable.value = controller.shouldSavePassword,
      );

  Widget get _saveItem => Obx(
        () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.toPadding),
            child: PuppyButton(
                onPressed: controller.saveEnable.value ? controller.save : null,
                style: PuppyButtonStyle.style1,
                buttonStyle: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(Get.width, 44))),
                child: const Text('保存',
                    style: TextStyle(
                        fontSize: kButtonFont, fontWeight: FontWeight.w600)))),
      );
}
