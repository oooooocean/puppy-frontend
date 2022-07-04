import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
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
  pushToPersonPage(int ownerId) {
    Get.toNamed(AppRoutes.userCenter, arguments: ownerId);
  }

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
        api: () => isCancel
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
