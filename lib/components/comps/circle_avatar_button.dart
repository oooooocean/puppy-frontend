import 'package:flutter/material.dart';

/// 圆形头像按钮
class CircleAvatarButton extends StatelessWidget {
  final String url;
  final VoidCallback onTap;

  const CircleAvatarButton({Key? key, required this.url, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: CircleAvatar(backgroundImage: NetworkImage(url)));
  }
}
