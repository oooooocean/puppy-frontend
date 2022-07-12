import 'package:flutter/material.dart';
import 'package:frontend/pages/login/login_controller.dart';
import 'package:frontend/pages/login/view/login_code_view.dart';
import 'package:frontend/pages/login/view/login_pwd_view.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);
  
  //TODO: 刷新整个页面, 重复代码
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Obx(() {
          switch (controller.loginStyle.value) {
            case LoginStyle.code:
              return LoginCodeView();
            case LoginStyle.password:
              return LoginPasswordView();
          }
        }),
      );
}
