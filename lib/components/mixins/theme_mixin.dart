import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

mixin ThemeMixin {
  final kBlackColor = const Color(0xff000022);
  final kBackgroundColor = Colors.white;
  final kPrimaryTextColor = const Color(0xff333333);
  final kSecondaryTextColor = const Color(0xff878787);
  final kGreyColor = Colors.grey[400]!;
  final kBorderColor = Colors.black12;
  final kShapeColor = const Color(0xfff1f1f1);
  final kOrangeColor = Colors.orange;
  final kBlueColor = const Color.fromARGB(255, 148, 177, 255);

  final double kDefaultPadding = 15.toPadding;

  double get widthRatio => Get.width / 390;

  final double kDefaultFont = 15; // 普通文字
  final double kSmallFont = 13;
  final double kButtonFont = 16;
}
