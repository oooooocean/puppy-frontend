import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';

/// 编辑框
class PuppyTextField extends StatelessWidget with ThemeMixin {
  final FocusNode focusNode;
  final TextEditingController controller;
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final ValueSetter<String>? onChanged;
  final TextAlign? textAlign;

  PuppyTextField(
      {Key? key,
      required this.focusNode,
      required this.controller,
      required this.maxLength,
      required this.hintText,
      this.maxLines,
      this.onChanged,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintStyle: const TextStyle(color: kBorderColor),
          hintText: hintText,
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder),
    );
  }

  InputBorder get _enabledBorder => (maxLines ?? 1) == 1
      ? const UnderlineInputBorder(borderSide: BorderSide(color: kBorderColor, width: 1))
      : const OutlineInputBorder(borderSide: BorderSide(color: kBorderColor, width: 1));

  InputBorder get _focusedBorder => (maxLines ?? 1) == 1
      ? UnderlineInputBorder(borderSide: BorderSide(color: kGreyColor, width: 1))
      : const OutlineInputBorder(borderSide: BorderSide(color: kSecondaryTextColor, width: 1));
}
