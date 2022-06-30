import 'package:flutter/material.dart';
import 'package:frontend/pages/login/login_controller.dart';
import 'package:frontend/pages/login/view/login_code_view.dart';
import 'package:frontend/pages/login/view/login_pwd_view.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      child: Obx(() {
        switch (controller.pageState.value) {
          case LoginPageState.code:
            return LoginCodeView();
          case LoginPageState.password:
            return LoginPwdView();
          default:
            return LoginCodeView();
        }
      }),
    ),
  );
}