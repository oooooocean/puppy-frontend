import 'package:frontend/components/mixins/refresh_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_comment.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/pages/post/mixin/post_action_mixin.dart';
import 'package:get/get.dart';

enum CommentFilter {
  /// 时间倒序
  timeDesc,

  /// 热度排序
  hot;

  @override
  String toString() {
    switch (this) {
      case CommentFilter.timeDesc:
        return '最新';
      case CommentFilter.hot:
        return '热度';
    }
  }
}

class PostDetailController extends GetxController with NetMixin, RefreshMixin<PostComment>, PostActionMixin<PostComment> {
  final Post mPost;

  PostDetailController(this.mPost);

  var commentFilter = CommentFilter.timeDesc.obs;

  /// 关注
  @override
  onTapFollow(Post post) {
    request(
        api: () => this.post('follow/', {'follow_id': mPost.owner}, (data) => data),
        success: (_) {
          mPost.social.hasFollow.value = true;
        });
  }

  /// 更多
  onTapMore() {}

  /// 话题
  @override
  onTapTopic(Post post, PostTopic topic) {}

  /// 评论
  onTapComment() {}

  /// 点赞
  onTapPraise() async {
    await praise(mPost);
  }

  /// 收藏
  onTapCollect() {}

  /// 关注的人
  @override
  onTapNotice(BaseUser user) {}

  onCommentToComment(PostComment comment) {}

  onPraiseToComment(PostComment comment) {}

  /// 筛选评论
  onFilterComment(CommentFilter? filter) {
    if (filter == null) return;
    commentFilter.value = filter;
  }

  /// 加载评论
  loadComments(RefreshType refreshType) {
    startRefresh(refreshType).then((value) {
      update(['comment']);
    });
  }

  @override
  Future<PagingData<PostComment>> get refreshRequest =>
      get('post/${mPost.id}/comment/', (data) => PagingData.fromJson(data, (json) => PostComment.fromJson(json)),
          query: {'page': paging.current.toString()});
}
