import 'package:frontend/components/mixins/refresh_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';

class PostListController extends GetxController with RefreshMixin<Post>, NetMixin {
  onRefresh() {
    startRefresh(RefreshType.refresh).then((value) => update());
  }

  onLoading() {
    startRefresh(RefreshType.loadMore).then((value) => update());
  }

  onTapPost(Post post) {}

  onTapAvatar(Post post) {}

  onTapPhoto(Post post, int index) {}

  onTapShare(Post post) {}

  onTapComment(Post post) {}

  onTapPraise(Post post) {
    post.hasPraise = true;
    update();
  }

  onTapTopic(Post post, PostTopic topic) {}

  @override
  Future<PagingData<Post>> get refreshRequest => get('post/', (data) => PagingData.fromJson(data, Post.fromJson),
      query: {'page': paging.current.toString(), 'start_id': items.isNotEmpty ? items.first.id.toString() : ''});
}
