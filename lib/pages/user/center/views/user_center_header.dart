import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/user/center/center_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/models/gender.dart';

class UserCenterHeader extends GetView<CenterController> with LoadImageMixin {
  final double height;
  final radius = 18.toPadding;

  UserCenterHeader({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, bottom: height / 3, right: 0, left: 0, child: buildAssetImage('login')),
        Positioned(
          left: 0,
          right: 0,
          top: Get.mediaQuery.viewPadding.top + kToolbarHeight + 20.toPadding,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius))),
            child: Column(
              children: [_actionBar],
            ),
          ),
        ),
        Positioned(
            left: kSpacePadding,
            width: 70,
            height: 70,
            top: Get.mediaQuery.viewPadding.top + kToolbarHeight,
            child: _avatarItem)
      ],
    );
  }

  Widget get _avatarItem => Stack(
        fit: StackFit.expand,
        children: [
          PuppyAvatarButton(didSelected: controller.onSelectedAvatar, defaultAvatar: controller.user.info?.avatarUrl),
          Positioned(
              bottom: 0,
              right: 0,
              width: 18.toPadding,
              height: 18.toPadding,
              child: Container(
                  decoration: const BoxDecoration(color: kShapeColor, shape: BoxShape.circle),
                  child: Icon(controller.user.info?.gender.humanIcon, color: Colors.lightBlue, size: 15.toPadding)))
        ],
      );

  Widget get _actionBar {
    final divider = VerticalDivider(indent: 10.toPadding, endIndent: 10.toPadding);

    return SizedBox(
      height: 44.toPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildActionButton(controller.user.social.praiseCount, '获赞', controller.onTapPraise),
          divider,
          _buildActionButton(controller.user.social.fansCount, '粉丝', controller.onTapFans),
          divider,
          _buildActionButton(controller.user.social.idolCount, '关注', controller.onTapIdols),
        ],
      ),
    );
  }

  Widget _buildActionButton(int title, String label, VoidCallback onPressed) => TextButton(
        onPressed: () {},
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), visualDensity: VisualDensity.compact),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title.toString(), style: const TextStyle(fontSize: kButtonFont)),
            Text(label, style: const TextStyle(fontSize: kSmallFont, color: kSecondaryTextColor))
          ],
        ),
      );
}
