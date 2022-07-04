import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/pages/post/detail/post_detail_controller.dart';
import 'package:get/get.dart';

class PostDetailBottomBar extends GetView<PostDetailController> {
  const PostDetailBottomBar({Key? key}) : super(key: key);

  Post get _post => controller.mPost;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Divider(height: 1, color: kGreyColor),
      Padding(
        padding: EdgeInsets.only(left: kDefaultPadding, bottom: Get.mediaQuery.viewPadding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _commentButton,
            const Spacer(),
            _buildButton(Icons.share_outlined, _post.social.praiseCount.toString(), controller.onTapPraise),
            Obx(() => _buildButton(_post.social.hasPraise.value ? Icons.favorite : Icons.favorite_outline,
                _post.social.praiseCount.toString(), controller.onTapPraise,
                color: _post.social.hasPraise.value ? kOrangeColor : kGreyColor)),
            _buildButton(Icons.star_outline, _post.social.praiseCount.toString(), controller.onTapCollect),
          ],
        ),
      )
    ]);
  }

  Widget get _commentButton => TextButton(
        onPressed: controller.onTapComment,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kShapeColor),
            visualDensity: VisualDensity.compact,
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: kDefaultPadding)),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))))),
        child: Text('友善评论, 欢乐撸宠~', style: TextStyle(color: kGreyColor)),
      );

  Widget _buildButton(IconData iconData, String text, VoidCallback onTap, {Color? color}) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Icon(iconData, size: 18, color: color ?? kGreyColor),
              Text(text, style: const TextStyle(color: kSecondaryTextColor, fontSize: 11))
            ],
          ),
        ),
      );
}
