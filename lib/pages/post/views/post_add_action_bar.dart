import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/post/add/post_add_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostAddActionBar extends GetView<PostAddController> {
  const PostAddActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _viewItem,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildAction(iconData: Icons.pets, onTap: controller.onTapPet),
            _buildAction(iconData: Icons.tag, onTap: controller.onTapTopic),
            _buildAction(iconData: Icons.alternate_email, onTap: controller.onTapFocus),
            _buildAction(iconData: Icons.location_on_outlined, onTap: controller.onTapMap),
          ],
        )
      ],
    );
  }

  Widget _buildAction({required IconData iconData, required VoidCallback onTap}) {
    return TextButton(
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        onPressed: onTap,
        child: Icon(iconData, color: kSecondaryTextColor));
  }

  Widget get _viewItem {
    return Obx(() {
      final icon = controller.isOpen.value ? Icons.public : Icons.lock;
      final color = controller.isOpen.value ? kOrangeColor : kSecondaryTextColor;
      final text = controller.isOpen.value ? '公开' : '仅自己可见';
      return TextButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kShapeColor),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10.toPadding, vertical: 0)),
            visualDensity: VisualDensity.compact,
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))))),
        onPressed: controller.onTapViewStyle,
        icon: Icon(icon, color: color, size: 16),
        label: Text(text, style: TextStyle(color: color)),
      );
    });
  }
}
