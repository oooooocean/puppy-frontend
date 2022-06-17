import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_action.dart';
import 'package:frontend/pages/post/list/post_list_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostListActionBar extends GetView<PostListController> {
  final Post post;

  const PostListActionBar({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = 16.toPadding;
    const iconColor = kSecondaryTextColor;

    final share = _actionLabelBuilder(
        Icon(PostAction.share.icon, size: iconSize, color: iconColor), '分享', () => controller.onTapShare(post));
    final comment = _actionLabelBuilder(Icon(PostAction.comment.icon, size: iconSize, color: iconColor),
        post.commentCount.toString(), () => controller.onTapComment(post));
    final praise = _actionLabelBuilder(
        Icon(post.hasPraise ? PostAction.praise.accentIcon : PostAction.praise.icon,
            color: post.hasPraise ? kOrangeColor : iconColor, size: iconSize),
        post.praiseCount.toString(),
        () => controller.onTapPraise(post));
    return ButtonBar(
        buttonPadding: EdgeInsets.zero, alignment: MainAxisAlignment.spaceBetween, children: [share, comment, praise]);
  }

  Widget _actionLabelBuilder(Icon icon, String text, VoidCallback onTap) => TextButton.icon(
      onPressed: onTap,
      icon: icon,
      label: Text(text, style: const TextStyle(color: kSecondaryTextColor, fontSize: kSmallFont)));
}
