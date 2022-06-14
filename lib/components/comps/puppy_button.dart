import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:get/get.dart';

enum PuppyButtonStyle {
  /// 白字 橙底
  style1,
  /// 橙字, 白底
  style2;

  Color getTextColor(bool enable) {
    switch (this) {
      case PuppyButtonStyle.style1:
        return enable ? Colors.white : kSecondaryTextColor;
      default:
        return enable ? Colors.orange : kGreyColor;
    }
  }

  Color getBackgroundColor(bool enable) {
    switch (this) {
      case PuppyButtonStyle.style1:
        return enable ? Colors.orange : kShapeColor;
      default:
        return Colors.white;
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
  final VoidCallback? onPress;
  final PuppyButtonStyle style;

  PuppyButton({Key? key, required this.child, required this.onPress, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) => style.getBackgroundColor(!states.contains(MaterialState.disabled))),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) => style.getTextColor(!states.contains(MaterialState.disabled))),
          fixedSize: style.size),
      child: child,
    );
  }
}
