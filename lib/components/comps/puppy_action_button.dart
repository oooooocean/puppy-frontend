import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';

/// 类似 UITableViewCell
class PuppyActionButton extends StatelessWidget with ThemeMixin {
  final VoidCallback onPressed;
  final String hint;
  final String? value;
  final Widget leading;

  PuppyActionButton({Key? key, required this.onPressed, required this.leading, this.hint = '点击选择', this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(children: [
        leading,
        Expanded(
            child: Text(value ?? hint,
                textAlign: TextAlign.end,
                style: TextStyle(color: value == null ? kSecondaryTextColor : kPrimaryTextColor))),
        Icon(Icons.chevron_right, color: kGreyColor)
      ]),
    );
  }
}
