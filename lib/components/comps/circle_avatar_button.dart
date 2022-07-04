import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';

/// 圆形头像按钮
class CircleAvatarButton extends StatelessWidget with LoadImageMixin {
  final String url;
  final VoidCallback onTap;
  final double? size;

  const CircleAvatarButton({Key? key, required this.url, required this.onTap, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child:
            SizedBox(width: size, height: size, child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(url))));
  }
}
