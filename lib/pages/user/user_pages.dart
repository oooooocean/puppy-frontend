import 'package:frontend/pages/user/feedback/feedback_controller.dart';
import 'package:frontend/pages/user/feedback/feedback_page.dart';
import 'package:frontend/pages/user/info/user_add_controller.dart';
import 'package:frontend/pages/user/info/user_add_page.dart';
import 'package:frontend/pages/user/info/user_edit_controller.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:frontend/pages/user/pet/pet_add_page.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

final userRoutes = [
  GetPage(
      name: AppRoutes.userInfoAdd,
      page: () => UserAddPage<UserAddController>(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserAddController()))),
  GetPage(
      name: AppRoutes.userInfoEdit,
      page: () => UserAddPage<UserEditController>(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserEditController()))),
  GetPage(
      name: AppRoutes.feedback,
      page: () => FeedbackPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => FeedbackController()))),
];

final petRoutes = [
  GetPage(
      name: AppRoutes.petAdd,
      page: () => PetAddPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PetAddController()))),
];
