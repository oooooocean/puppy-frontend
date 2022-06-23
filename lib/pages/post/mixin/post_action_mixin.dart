import 'dart:async';
import 'package:frontend/models/media.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';

mixin PostActionMixin on NetMixin {
  /// 图片, 视频等
  pushToMediaPage(List<Media> medias, int index) {
    Get.toNamed(AppRoutes.mediaBrowser, arguments: Tuple2(medias, index));
  }

  /// 个人主页
  pushToPersonPage(int ownerId) {}

  /// 关注
  Future<bool> follow(int followId) {
    final completer = Completer<bool>();
    request(
        api: () => post('follow/', {'follow_id': followId}, (data) => data),
        success: (_) => completer.complete(true),
        fail: (_) => completer.complete(false));
    return completer.future;
  }

  /// 点赞
  Future<bool> praise(Post post) {
    final isCancel = post.hasPraise.value;
    final completer = Completer<bool>();
    request(
        api: () =>
        isCancel
            ? delete('post/${post.id}/praise/', {}, (data) => data)
            : this.post('post/${post.id}/praise/', {}, (data) => data),
        success: (_) {
          post.praiseCount += isCancel ? -1 : 1;
          post.hasPraise.value = !post.hasPraise.value;
          completer.complete(true);
        },
        fail: (_) => completer.complete(false));
    return completer.future;
  }
}
