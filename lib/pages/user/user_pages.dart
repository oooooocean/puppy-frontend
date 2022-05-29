import 'package:frontend/pages/user/info/user_info_controller.dart';
import 'package:frontend/pages/user/info/user_info_page.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

final appRoutes = [
  GetPage(
      name: AppRoutes.userInfoEdit,
      page: () => UserInfoPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserInfoController()))),
];