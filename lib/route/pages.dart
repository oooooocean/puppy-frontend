import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

part 'routes.dart';

final appRoutes = [
  GetPage(name: AppRoutes.login, page: () => const Center(child: Text("宠物星球"))),
];
