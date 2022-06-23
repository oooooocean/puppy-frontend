import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:get/get.dart';

enum PuppyButtonStyle {
  /// 白字 橙底, 变色
  style1,

  /// 橙字, 白底, 变色
  style2,

  /// 黑字, 灰底, 不变色
  style3,

  /// 橙字, 灰底, 变色
  style4;

  Color getTextColor(bool enable) {
    switch (this) {
      case PuppyButtonStyle.style1:
        return enable ? Colors.white : kSecondaryTextColor;
      case PuppyButtonStyle.style2:
        return enable ? Colors.orange : kGreyColor;
      case PuppyButtonStyle.style3:
        return kPrimaryTextColor;
      case PuppyButtonStyle.style4:
        return enable ? Colors.orange : kPrimaryTextColor;
    }
  }

  Color getBackgroundColor(bool enable) {
    switch (this) {
      case PuppyButtonStyle.style1:
        return enable ? Colors.orange : kShapeColor;
      case PuppyButtonStyle.style2:
        return Colors.white;
      case PuppyButtonStyle.style3:
        return kShapeColor;
      case PuppyButtonStyle.style4:
        return kShapeColor;
    }
  }

  MaterialStateProperty<Size>? get size {
    switch (this) {
      case PuppyButtonStyle.style1:
        return MaterialStateProperty.all(Size(Get.width, 44));
      default:
        return null;
    }
  }
}

/// 提交按钮
class PuppyButton extends StatelessWidget with ThemeMixin {
  final Widget child;
  final VoidCallback? onPressed;
  final PuppyButtonStyle style;
  final ButtonStyle? buttonStyle;

  PuppyButton({Key? key, required this.child, required this.onPressed, required this.style, this.buttonStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mergedStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) => style.getBackgroundColor(!states.contains(MaterialState.disabled))),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) => style.getTextColor(!states.contains(MaterialState.disabled))),
        fixedSize: style.size);
    if (buttonStyle != null) {
      mergedStyle = mergedStyle.merge(buttonStyle);
    }
    return TextButton(
      onPressed: onPressed,
      style: mergedStyle,
      child: child,
    );
  }
}
