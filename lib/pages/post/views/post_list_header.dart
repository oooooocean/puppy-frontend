import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/comps/circle_avatar_button.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/pages/post/list/post_list_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostListHeader extends GetView<PostListController> {
  final Post post;

  const PostListHeader({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.toPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _avatarItem,
              SizedBox(width: 5.toPadding),
              Text(post.ownerInfo.nickname, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
            ],
          ),
          Row(mainAxisSize: MainAxisSize.min, children: [_followItem, _moreItem])
        ],
      ),
    );
  }

  Widget get _avatarItem {
    final width = 38.toPadding;
    return SizedBox(
      width: width,
      height: width,
      child: CircleAvatarButton(url: post.avatarUrl, onTap: () => controller.onTapAvatar(post)),
    );
  }

  Widget get _followItem => OutlinedButton(
      onPressed: () => controller.onTapFollow(post),
      style: const ButtonStyle(visualDensity: VisualDensity.compact),
      child: const Text(
        '关注',
        style: TextStyle(fontSize: kSmallFont, color: kOrangeColor),
      ));

  Widget get _moreItem => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.onTapMoreOptions(post),
        child: const SizedBox(
          width: 20,
          height: 50,
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.close, size: 12, color: kSecondaryTextColor),
          ),
        ),
      );
}
