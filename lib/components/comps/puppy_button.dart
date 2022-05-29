import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:get/get.dart';

enum PuppyButtonStyle {
  style1,
  style2;

  Color getTextColor(bool enable) {
    switch (this) {
      case PuppyButtonStyle.style1:
        return enable ? Colors.white : const Color(0xff878787);
      default:
        return enable ? Colors.orange : Colors.black26;
    }
  }

  Color getBackgroundColor(bool enable) {
    switch (this) {
      case PuppyButtonStyle.style1:
        return enable ? Colors.orange : Colors.grey.withOpacity(0.25);
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
