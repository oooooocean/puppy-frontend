import 'package:flutter/material.dart';
import 'package:frontend/components/comps/circle_avatar_button.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/pages/post/mixin/post_action_mixin.dart';
import 'package:frontend/pages/post/mixin/post_ui_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostListHeader<C extends PostActionMixin> extends GetView<C> with PostUIMixin {
  final Post post;

  const PostListHeader({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.toPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _avatarItem,
          SizedBox(width: 5.toPadding),
          Text(post.ownerInfo.nickname, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const Spacer(),
          _buildActionBar
        ],
      ),
    );
  }

  Widget get _buildActionBar {
    switch (Get.currentRoute) {
      case AppRoutes.userCenter:
        return _moreItem;
      default:
        return Row(mainAxisSize: MainAxisSize.min, children: [_followItem, _moreItem]);
    }
  }

  Widget get _avatarItem {
    final width = 38.toPadding;
    return SizedBox(
      width: width,
      height: width,
      child: CircleAvatarButton(url: post.ownerInfo.avatarUrl, onTap: () => controller.onTapAvatar(post)),
    );
  }

  Widget get _followItem => buildFollowItem(post, () => controller.onTapFollow(post));

  Widget get _moreItem => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.onTapMoreOptions(post),
        child: SizedBox(
          width: 20.toPadding,
          height: 50.toPadding,
          child: const Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.close, size: 12, color: kSecondaryTextColor),
          ),
        ),
      );
}
