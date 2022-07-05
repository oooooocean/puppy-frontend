import 'package:frontend/components/mixins/refresh_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/pages/post/mixin/post_action_mixin.dart';
import 'package:get/get.dart';

class CenterPostController extends GetxController with RefreshMixin<Post>, NetMixin, PostActionMixin<Post> {
  final int userId;

  CenterPostController(this.userId);

  var enableRefresh = true;

  @override
  onRefresh() {
    startRefresh(RefreshType.refresh).then((value) {
      enableRefresh = false;
      update();
    });
  }

  @override
  Future<PagingData<Post>> get refreshRequest => get('post/', (data) => PagingData.fromJson(data, Post.fromJson),
      query: {'page': paging.current.toString(), 'start_id': items.isNotEmpty ? items.first.id.toString() : '', 'user_id': userId.toString()});
}
