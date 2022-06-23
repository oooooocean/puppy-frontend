import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/post/detail/post_detail_controller.dart';
import 'package:get/get.dart';

class PostCommentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final int commentCount;
  final int praiseCount;

  PostCommentHeaderDelegate({required this.commentCount, required this.praiseCount});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      PostCommentHeader(commentCount: commentCount, praiseCount: praiseCount);

  @override
  double get maxExtent => 46.0;

  @override
  double get minExtent => 46.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration {
    return const PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: double.infinity,
    );
  }
}

class PostCommentHeader extends GetView<PostDetailController> {
  final int commentCount;
  final int praiseCount;

  const PostCommentHeader({Key? key, required this.commentCount, required this.praiseCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 46,
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('评论 $commentCount', style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 10.toPadding),
            Text('赞 $praiseCount', style: const TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            _filterItem,
          ],
        ));
  }

  Widget get _filterItem => Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<CommentFilter>(
              isDense: true,
              value: controller.commentFilter.value,
              items: CommentFilter.values
                  .map((e) => DropdownMenuItem(
                      value: e, child: Text(e.toString(), style: const TextStyle(fontSize: kSmallFont))))
                  .toList(),
              onChanged: controller.onFilterComment),
        ),
      );
}
