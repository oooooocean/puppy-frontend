import 'package:get/get.dart';

extension DoubleThemeSupport on double {
  double get toPadding => Get.width / 390 * this;
}