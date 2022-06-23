import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/post/detail/post_detail_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostDetailShareBar extends GetView<PostDetailController> {
  const PostDetailShareBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(Icons.wechat, Colors.lightGreen, () { }),
        _buildActionButton(Icons.camera, Colors.greenAccent, () { })
      ],
    );
  }

  Widget _buildActionButton(IconData iconData, Color iconColor, VoidCallback onTap) => TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          padding: MaterialStateProperty.all(EdgeInsets.all(15.toPadding)),
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(kShapeColor)
        ),
        child: Icon(iconData, color: iconColor, size: 25,),
      );
}
