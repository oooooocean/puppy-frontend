import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/post/comment/post_comment_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostCommentPage extends GetView<PostCommentController> {
  const PostCommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlackColor.withOpacity(0.5),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => Get.back())),
              _content
            ],
          ),
        ));
  }

  Widget get _content => Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15.toPadding, right: 15.toPadding, bottom: Get.mediaQuery.viewPadding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              textInputAction: TextInputAction.send,
              controller: controller.commentCtl,
              onChanged: (value) => controller.enableComment.value = value.isNotEmpty,
              onSubmitted: (_) => controller.onTapComment(),
              decoration: InputDecoration(
                  hintText: '友善评论, 欢乐撸宠~',
                  suffix: Obx(
                    () => PuppyButton(
                        style: PuppyButtonStyle.style4,
                        onPressed: controller.enableComment.value ? controller.onTapComment : null,
                        child: const Text('发送')),
                  )),
            ),
          ],
        ),
      );
}
