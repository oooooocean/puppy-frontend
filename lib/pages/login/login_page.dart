import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/comps/puppy_button.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';

class LoginPage extends GetView<LoginController> with ThemeMixin, LoadImageMixin, KeyboardAllocator {
  final photoNode = FocusNode();
  final codeNode = FocusNode();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardActions(
          disableScroll: false,
          config: doneKeyboardConfig([photoNode, codeNode]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.toPadding),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              buildAssetImage('logo', width: Get.width * 0.35),
              _inputContainer,
              Column(children: [_loginItem, Padding(padding: EdgeInsets.only(top: 35.toPadding), child: _otherItem)])
            ]),
          ),
        ),
      ),
    );
  }

  Widget get _inputContainer => Container(
        padding: EdgeInsets.all(15.toPadding),
        decoration: BoxDecoration(color: kShapeColor, borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [_phoneItem, _codeItem],
        ),
      );

  Widget get _phoneItem => TextField(
        focusNode: photoNode,
        controller: controller.phoneCtl,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(hintText: '铲屎的, 手机号填在这里👇'),
        onChanged: (_) => controller.codeEnable.value = controller.shouldFetchCode,
      );

  Widget get _codeItem => Row(children: [
        Expanded(
          child: TextField(
            controller: controller.codeCtl,
            focusNode: codeNode,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(hintText: '验证码填在这里👇'),
            onChanged: (_) => controller.loginEnable.value = controller.shouldLogin,
          ),
        ),
        SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0), // 对齐文字
            child: Obx(
              () => PuppyButton(
                onPress: controller.codeEnable.value
                    ? () {
                        controller.fetchCode();
                        codeNode.requestFocus();
                      }
                    : null,
                style: PuppyButtonStyle.style2,
                child: Obx(() => Text(controller.codeCounter.value)),
              ),
            ),
          ),
        ),
      ]);

  Widget get _loginItem => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => PuppyButton(
                onPress: controller.loginEnable.value ? controller.login : null,
                style: PuppyButtonStyle.style1,
                child: const Text('进入星球', style: TextStyle(fontSize: kButtonFont, fontWeight: FontWeight.w600))),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Checkbox(
                      side: BorderSide(color: kGreyColor),
                      value: controller.selectedClause.value,
                      onChanged: (value) {
                        controller.selectedClause.value = value ?? false;
                        controller.loginEnable.value = controller.shouldLogin;
                      },
                      shape: const CircleBorder(),
                      activeColor: kOrangeColor,
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      checkColor: Colors.white),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  child: Text('同意用户协议和隐私政策',
                      style: TextStyle(
                          fontSize: 13,
                          color: kSecondaryTextColor,
                          decoration: TextDecoration.underline,
                          decorationColor: kSecondaryTextColor)),
                )
              ],
            ),
          ),
        ],
      );

  Widget get _otherItem => Column(mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          Expanded(child: Divider(color: kGreyColor)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.toPadding),
              child: Text('其他进入星球的方式👇', style: TextStyle(color: kSecondaryTextColor, fontSize: kSmallFont))),
          Expanded(child: Divider(color: kGreyColor))
        ]),
        SizedBox(height: 25.toPadding),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(onPressed: controller.loginWithWeChat, icon: buildAssetImage('wechat-logo')),
          SizedBox(width: 20.toPadding),
          SizedBox(
            width: 120,
            child: SignInWithAppleButton(
                onPressed: controller.loginWithAppleId,
                text: 'Apple登录',
                style: SignInWithAppleButtonStyle.black,
                height: 32),
          )
        ])
      ]);
}
