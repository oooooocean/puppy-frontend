import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/pages/post/mixin/post_ui_mixin.dart';
import 'package:frontend/pages/post/detail/post_detail_controller.dart';
import 'package:frontend/pages/post/views/post_commnet_header.dart';
import 'package:frontend/pages/post/views/post_description_tile.dart';
import 'package:frontend/pages/post/views/post_detail_bottom_bar.dart';
import 'package:frontend/pages/post/views/post_detail_comment_tile.dart';
import 'package:frontend/pages/post/views/post_detail_share_bar.dart';
import 'package:frontend/pages/post/views/post_photos_tile.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/extension/date_extension.dart';

class PostDetailPage extends GetView<PostDetailController> with LoadImageMixin, PostUIMixin {
  final avatarWidth = 30.toPadding;

  PostDetailPage({Key? key}) : super(key: key);

  Post get _post => controller.mPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Column(
        children: [Expanded(child: _body), const PostDetailBottomBar()],
      ),
    );
  }

  AppBar get _appBar => AppBar(
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ClipOval(child: _buildAvatar(_post.ownerInfo.avatarUrl)),
            SizedBox(width: 5.toPadding),
            Text(_post.ownerInfo.nickname)
          ]),
        ),
        actions: [
          UnconstrainedBox(child: buildFollowItem(_post, controller.onTapFollow)),
          IconButton(onPressed: controller.onTapMore, icon: const Icon(Icons.more_horiz))
        ],
      );

  Widget get _body => GetBuilder<PostDetailController>(
        id: 'comment',
        builder: (_) => SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () => controller.loadComments(RefreshType.refresh),
          onLoading: () => controller.loadComments(RefreshType.loadMore),
          enablePullUp: true,
          child: CustomScrollView(slivers: [
            _descriptionItem,
            _mediaItem,
            _supplementItem,
            _shareItem,
            _divider,
            _commentHeader,
            _divider2,
            _commentList
          ]),
        ),
      );

  SliverToBoxAdapter get _descriptionItem => SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSpacePadding),
        child: PostDescriptionTile(
            description: _post.description,
            topics: _post.topics,
            notices: _post.noticeUsers,
            onNotice: controller.onTapNotice,
            onTap: controller.onTapTopic),
      ));

  SliverToBoxAdapter get _mediaItem => SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: PostPhotosTile(photos: _post.medias, onTap: (index) => controller.pushToMediaPage(_post.medias, index)),
      ));

  SliverToBoxAdapter get _supplementItem => SliverToBoxAdapter(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSpacePadding),
        alignment: Alignment.centerRight,
        child: Text('发布于 ${_post.createTime.yyyymmdd}',
            style: const TextStyle(color: kSecondaryTextColor, fontSize: kSmallFont)),
      ));

  SliverToBoxAdapter get _shareItem => const SliverToBoxAdapter(child: PostDetailShareBar());

  SliverList get _commentList => SliverList(
          delegate: SliverChildBuilderDelegate((_, index) {
        final comment = controller.items[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: PostDetailCommentTile(comment: comment),
        );
      }, childCount: controller.items.length));

  SliverPersistentHeader get _commentHeader => SliverPersistentHeader(
      pinned: true,
      delegate: PostCommentHeaderDelegate(commentCount: _post.commentCount, praiseCount: _post.praiseCount));

  SliverToBoxAdapter get _divider => SliverToBoxAdapter(
      child: Padding(
          padding: EdgeInsets.only(top: kSpacePadding),
          child: Divider(thickness: kSpacePadding, height: kSpacePadding)));

  SliverToBoxAdapter get _divider2 => const SliverToBoxAdapter(child: Divider(height: 1));

  Widget _buildAvatar(String url) => buildNetImage(url, width: avatarWidth, height: avatarWidth);
}
