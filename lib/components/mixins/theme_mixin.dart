import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

mixin ThemeMixin {
  final backgroundColor = const Color(0xff000022);
  final primaryTextColor = const Color(0xff333333);
  final secondaryTextColor = const Color(0xff878787);
  final greyColor = Colors.black26;
  final borderColor = Colors.white.withOpacity(0.5);
  final blueColor = const Color.fromARGB(255, 144, 177, 255);
  final orangeColor = Colors.orange;

  final double defaultPadding = 15.toPadding;

  double get widthRatio => Get.width / 390;

  final double defaultFont = 15; // 普通文字
  final double smallFont = 13;
  final double buttonFont = 16;
}
