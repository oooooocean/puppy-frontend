import 'package:frontend/debug.dart';
import 'package:frontend/pages/login/login_controller.dart';
import 'package:frontend/pages/login/login_page.dart';
import 'package:frontend/pages/scaffold/scaffold_controller.dart';
import 'package:frontend/pages/scaffold/scaffold_page.dart';
import 'package:get/get.dart';
import 'package:frontend/pages/user/user_pages.dart' as user_pages;

part 'routes.dart';

final appRoutes = [
  GetPage(name: AppRoutes.debug, page: () => const DebugPage()),
  GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController()))),
  GetPage(
      name: AppRoutes.scaffold,
      page: () => const ScaffoldPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ScaffoldController()))),
  ...user_pages.appRoutes,
];
