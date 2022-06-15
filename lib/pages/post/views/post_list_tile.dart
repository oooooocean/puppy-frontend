import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/comps/circle_avatar_button.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_action.dart';
import 'package:frontend/pages/post/list/post_list_controller.dart';
import 'package:frontend/pages/post/views/post_description_tile.dart';
import 'package:frontend/pages/post/views/post_photos_tile.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostListTile extends GetView<PostListController> with LoadImageMixin {
  final Post post;
  final space = const SizedBox(height: 5);
  final ValueSetter<Post> onTap;

  PostListTile({Key? key, required this.post, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(post),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [space, _headerItem, space, _descriptionItem, space, _photosItem, _panel],
          ),
        ),
      ),
    );
  }

  Widget get _headerItem => SizedBox(
        height: 50.toPadding,
        child: Row(
          children: [
            _avatarItem,
            SizedBox(width: 5.toPadding),
            Text(post.ownerInfo.nickname, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
          ],
        ),
      );

  Widget get _avatarItem {
    final width = 38.toPadding;
    return SizedBox(
      width: width,
      height: width,
      child: CircleAvatarButton(url: post.avatarUrl, onTap: () => controller.onTapAvatar(post)),
    );
  }

  Widget get _descriptionItem => PostDescriptionTile(
      description: post.description, topics: post.topics, onTap: (topic) => controller.onTapTopic(post, topic));

  Widget get _photosItem => PostPhotosTile(photos: post.medias, onTap: (index) => controller.onTapPhoto(post, index));

  Widget get _panel {
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
