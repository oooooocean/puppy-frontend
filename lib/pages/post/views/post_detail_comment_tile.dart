import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post_comment.dart';
import 'package:frontend/pages/post/detail/post_detail_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/extension/date_extension.dart';

class PostDetailCommentTile extends GetView<PostDetailController> with LoadImageMixin {
  final PostComment comment;
  final avatarWidth = 30.toPadding;

  PostDetailCommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: kSpacePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(child: buildNetImage(comment.ownerInfo.avatarUrl, width: avatarWidth, height: avatarWidth)),
          SizedBox(width: kSpacePadding),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(comment.ownerInfo.nickname, style: const TextStyle(color: kSecondaryTextColor2)),
            Text(comment.description),
            _bottomItem,
            const Divider(height: 1)
          ])),
        ],
      ),
    );
  }

  Widget get _bottomItem => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.toPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(comment.createTime.yyyymmddhhmm, style: TextStyle(fontSize: kSmallFont, color: kGreyColor)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBottomAction(Icons.comment, controller.onCommentToComment),
                _buildBottomAction(Icons.thumb_up_alt_outlined, controller.onPraiseToComment)
              ],
            )
          ],
        ),
      );

  Widget _buildBottomAction(IconData iconData, ValueSetter<PostComment> onTap) => GestureDetector(
        onTap: () => onTap(comment),
        child: Padding(
          padding: EdgeInsets.only(left: kSpacePadding),
          child: Icon(iconData, size: 16, color: kGreyColor),
        ),
      );
}
