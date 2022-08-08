import 'package:frontend/pages/login/login_controller.dart';
import 'package:frontend/pages/login/login_page.dart';
import 'package:frontend/pages/login/password/password_set_page.dart';
import 'package:frontend/pages/login/password/password_controller.dart';
import 'package:frontend/pages/login/password/password_reset_page.dart';
import 'package:frontend/pages/login/launch_service_page.dart';
import 'package:frontend/pages/login/launch_service_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

final loginRoutes = [
  GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController()))),
  GetPage(
      name: AppRoutes.loginSetPassword,
      page: () => PasswordSetPage(),
      binding: BindingsBuilder(
          () => Get.lazyPut(() => PasswordController(PasswordStyle.set)))),
  GetPage(
      name: AppRoutes.loginResetPassword,
      page: () => PasswordResetPage(),
      binding: BindingsBuilder(
          () => Get.lazyPut(() => PasswordController(PasswordStyle.reset)))),
  GetPage(
      name: AppRoutes.launchServiceFlow,
      page: () => LaunchServicePage(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => LaunchServiceController()))),
];