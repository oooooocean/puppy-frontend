import 'package:frontend/pages/user/feedback/feedback_controller.dart';
import 'package:frontend/pages/user/feedback/feedback_page.dart';
import 'package:frontend/pages/user/center/center_controller.dart';
import 'package:frontend/pages/user/center/center_page.dart';
import 'package:frontend/pages/user/info/user_add_controller.dart';
import 'package:frontend/pages/user/info/user_add_page.dart';
import 'package:frontend/pages/user/info/user_edit_controller.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:frontend/pages/user/pet/pet_add_page.dart';
import 'package:frontend/pages/user/pet/pet_category_page.dart';
import 'package:frontend/pages/user/setting/setting_controller.dart';
import 'package:frontend/pages/user/setting/setting_page.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

final userRoutes = [
  GetPage(
      name: AppRoutes.userInfoAdd,
      page: () => UserAddPage<UserAddController>(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserAddController()))),
  GetPage(
      name: AppRoutes.userSetting,
      page: () => const SettingPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SettingController()))),
  GetPage(
      name: AppRoutes.userInfoEdit,
      page: () => UserAddPage<UserEditController>(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserEditController()))),
  GetPage(
      name: AppRoutes.userCenter,
      page: () => CenterPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => CenterController(Get.arguments)))),
];

final petRoutes = [
  GetPage(
      name: AppRoutes.petAdd,
      page: () => PetAddPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PetAddController()))),

];
final settingRoutes = [
  GetPage(
      name: AppRoutes.feedback,
      page: () => FeedbackPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => FeedbackController()))),

  GetPage(
      name: AppRoutes.petCategory,
      page: () => PetCategoryPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PetCategoryController(Get.arguments)))),
];
