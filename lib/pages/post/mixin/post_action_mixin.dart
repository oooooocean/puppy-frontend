import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/refresh_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/media.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';

mixin PostActionMixin<T> on GetxController, NetMixin, RefreshMixin<T> {
  /// 刷新
  onRefresh() {
    return startRefresh(RefreshType.refresh).then((value) => update());
  }

  /// 加载更多
  onLoading() {
    return startRefresh(RefreshType.loadMore).then((value) => update());
  }

  /// 点击帖子
  onTapPost(Post post) {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

  /// 关注的人
  onTapNotice(BaseUser user) {}

  onTapFollow(Post post) => UnimplementedError('子类实现');

  /// 主题
  onTapTopic(Post post, PostTopic topic) {}

  /// 点击头像
  onTapAvatar(Post post) {
    pushToPersonPage(post.owner);
  }

  /// 图片, 视频等
  pushToMediaPage(List<Media> medias, int index) {
    Get.toNamed(AppRoutes.mediaBrowser, arguments: Tuple2(medias, index));
  }

  /// 个人主页
  pushToPersonPage(int ownerId) {
    final isLoginUser = LaunchService.shared.user!.id == ownerId;
    Get.toNamed(isLoginUser ? AppRoutes.loginUserCenter : AppRoutes.userCenter, arguments: ownerId);
  }

  /// 点赞
  Future<bool> praise(Post post) {
    final isCancel = post.social.hasPraise.value;
    final completer = Completer<bool>();
    request(
        api: () => isCancel
            ? delete('post/${post.id}/praise/', {}, (data) => data)
            : this.post('post/${post.id}/praise/', {}, (data) => data),
        success: (_) {
          post.social.praiseCount += isCancel ? -1 : 1;
          post.social.hasPraise.value = !post.social.hasPraise.value;
          completer.complete(true);
        },
        fail: (_) => completer.complete(false));
    return completer.future;
  }

  /// 反馈
  onTapMoreOptions(Post post) async {
    final result = await Get.bottomSheet<int>(
        Padding(
          padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kSpacePadding,
              bottom: kSpacePadding + Get.mediaQuery.padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('内容反馈:', style: TextStyle(color: kSecondaryTextColor, fontSize: kSmallFont)),
              TextButton.icon(
                  onPressed: () => Get.back(result: 0),
                  icon: const Icon(Icons.warning_amber_outlined),
                  label: const Text('举报帖子')),
              const Divider(),
              TextButton.icon(
                  onPressed: () => Get.back(result: 1),
                  icon: const Icon(Icons.sentiment_very_dissatisfied_outlined),
                  label: const Text('屏蔽作者'))
            ],
          ),
        ),
        backgroundColor: Colors.white);
    if (result == null) return;

    switch (result) {
      case 0:
        break;
      case 1:
        break;
      default:
        break;
    }
  }
}
