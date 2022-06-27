import 'package:frontend/pages/social/idols/idol_list_controller.dart';
import 'package:frontend/pages/social/idols/idol_list.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(
      fullscreenDialog: true,
      name: AppRoutes.choseIdol,
      page: () => const IdolListPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => IdolListController()))),
];
