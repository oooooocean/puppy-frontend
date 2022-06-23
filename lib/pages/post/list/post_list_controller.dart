import 'package:frontend/components/mixins/refresh_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/pages/post/mixin/post_action_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';

class PostListController extends GetxController with RefreshMixin<Post>, NetMixin, PostActionMixin {
  /// 刷新
  onRefresh() {
    startRefresh(RefreshType.refresh).then((value) => update());
  }

  /// 加载更多
  onLoading() {
    startRefresh(RefreshType.loadMore).then((value) => update());
  }

  /// 点击帖子
  onTapPost(Post post) {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

  /// 点击头像
  onTapAvatar(Post post) {
    pushToPersonPage(post.owner);
  }

  /// 关注
  onTapFollow(Post post) async {
    final result = await follow(post.owner);
    if (!result) return;
    final needUpdatePosts = items.where((element) => element.owner == post.owner).map((e) {
      e.hasFollow.value = true;
      return e.id;
    }).toList();
    update(needUpdatePosts);
  }

  onTapShare(Post post) {}

  /// 评论
  onTapComment(Post post) async {
    final result = await Get.toNamed(AppRoutes.postComment, arguments: post.id) as bool?;
    if (result == null || !result) return;
    post.commentCount += 1;
    update([post.id]);
  }

  /// 点赞
  onTapPraise(Post post) async {
    await praise(post);
  }

  /// 主题
  onTapTopic(Post post, PostTopic topic) {}

  onTapMoreOptions(Post post) {}

  @override
  Future<PagingData<Post>> get refreshRequest => get('post/', (data) => PagingData.fromJson(data, Post.fromJson),
      query: {'page': paging.current.toString(), 'start_id': items.isNotEmpty ? items.first.id.toString() : ''});
}
