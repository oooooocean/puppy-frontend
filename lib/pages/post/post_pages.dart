import 'package:frontend/pages/post/add/post_add.dart';
import 'package:frontend/pages/post/add/post_add_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

final postRoutes = [
  GetPage(
      name: AppRoutes.postAdd,
      page: () => const PostAddPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PostAddController()))),
];