import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/app.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(initRoute: await _init()));
}

Future<String> _init() async {
  await LaunchService.shared.init();
  Get.put(LaunchService.shared);
  return LaunchService.shared.firstRoute;
}