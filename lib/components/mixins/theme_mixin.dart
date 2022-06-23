import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

bool isDark = false;

const kBlackColor = Color(0xff000022);
const kBackgroundColor = Colors.white;
const kPrimaryTextColor = Color(0xff333333);
const kSecondaryTextColor = Color(0xff878787);
const kSecondaryTextColor2 = Color(0xff555555);
final kGreyColor = Colors.grey[400]!;
const kBorderColor = Colors.black12;
const kShapeColor = Color(0xfff1f1f1);
const kOrangeColor = Colors.orange;
const kBlueColor = Color(0xff426ab3);

const double kDefaultFont = 15; // 普通文字
const double kSmallFont = 13;
const double kButtonFont = 16;

final double kDefaultPadding = 15.toPadding;
final double kSpacePadding = 8.toPadding;

mixin ThemeMixin {
  double get widthRatio => Get.width / 390;
}
