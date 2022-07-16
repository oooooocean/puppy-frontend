import 'package:frontend/components/mixins/refresh_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/pages/post/mixin/post_action_mixin.dart';
import 'package:frontend/pages/social/social_action_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

class PostListController extends GetxController
    with
        RefreshMixin<Post>,
        NetMixin,
        PostActionMixin<Post>,
        SocialActionMixin {
  /// 关注
  @override
  onTapFollow(Post post) async {
    final result = await follow(followId: post.owner, isCancel: false);
    if (!result) return;
    final needUpdatePosts =
        items.where((element) => element.owner == post.owner).map((e) {
      e.social.hasFollow.value = true;
      return e.id;
    }).toList();
    update(needUpdatePosts);
  }

  onTapShare(Post post) {}

  /// 评论
  onTapComment(Post post) async {
    final result =
        await Get.toNamed(AppRoutes.postComment, arguments: post.id) as bool?;
    if (result == null || !result) return;
    post.social.commentCount += 1;
    update([post.id]);
  }

  /// 点赞
  onTapPraise(Post post) async {
    await praise(post);
  }

  @override
  Future<PagingData<Post>> get refreshRequest =>
      get('post/', (data) => PagingData.fromJson(data, Post.fromJson), query: {
        'page': paging.current.toString(),
        'start_id': items.isNotEmpty ? items.first.id.toString() : ''
      });
}
