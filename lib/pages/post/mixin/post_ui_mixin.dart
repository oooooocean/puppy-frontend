import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post.dart';
import 'package:get/get.dart';

mixin PostUIMixin {
  Widget buildFollowItem(Post post, VoidCallback onTap) {
    return post.isCurrentUser
        ? Container()
        : Obx(
            () => OutlinedButton(
              onPressed: post.social.hasFollow.value ? null : onTap,
              style: ButtonStyle(
                  visualDensity: VisualDensity.compact, padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Text(
                post.social.hasFollow.value ? '已关注' : '关注',
                style: TextStyle(
                    fontSize: kSmallFont, color: post.social.hasFollow.value ? kSecondaryTextColor : kOrangeColor),
              ),
            ),
          );
  }
}
