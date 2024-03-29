import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet.dart';
import 'package:frontend/pages/user/center/user_center_controller.dart';
import 'package:frontend/services/qiniu_service.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/extension/image_extension.dart';
import 'package:frontend/models/gender.dart';

class UserCenterHeader<C extends UserCenterController> extends GetView<C> with LoadImageMixin {
  final double height;
  final radius = 18.toPadding;
  final avatarWidth = 70.toPadding;

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
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSpacePadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_actionBar, _nicknameItem, _descriptionItem, _petsItem],
            ),
          ),
        ),
        Positioned(
            left: kSpacePadding,
            width: avatarWidth,
            height: avatarWidth,
            top: Get.mediaQuery.viewPadding.top + kToolbarHeight,
            child: _avatarItem)
      ],
    );
  }

  /// 头像
  Widget get _avatarItem => Stack(
        fit: StackFit.expand,
        children: [
          _buildAvatar,
          Positioned(
              bottom: 0,
              right: 0,
              width: 18.toPadding,
              height: 18.toPadding,
              child: Container(
                  decoration: const BoxDecoration(color: kShapeColor, shape: BoxShape.circle),
                  child: Icon(controller.user.info.gender.humanIcon, color: Colors.lightBlue, size: 15.toPadding)))
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

  Widget get _nicknameItem => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(controller.user.info.nickname, style: TextStyle(fontSize: 20.toPadding, fontWeight: FontWeight.bold)),
          _actionButton
        ],
      );

  Widget get _descriptionItem => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('简介'),
          const SizedBox(width: kDefaultFont),
          Expanded(
            child: Text(controller.user.info.introduction,
                maxLines: 2, style: const TextStyle(color: kSecondaryTextColor2, fontSize: kSmallFont)),
          )
        ],
      );

  Widget get _petsItem {
    final pets = controller.pets.isEmpty
        ? [const Text('ta连个宠物都没有, 太可怜了~', style: TextStyle(fontSize: kSmallFont))]
        : controller.pets.map(_buildPetImage);

    return Row(
      children: [_buildTitle('宠物'), const SizedBox(width: kDefaultFont), ...pets],
    );
  }

  Widget get _actionButton => Obx(
        () => PuppyButton(
        onPressed: controller.onTapFollow,
        style: controller.user.social.hasFollow.value ? PuppyButtonStyle.style3 : PuppyButtonStyle.style1,
        buttonStyle: const ButtonStyle(visualDensity: VisualDensity.compact),
        child: Text(controller.user.social.hasFollow.value ? '已关注' : '关注',
            style: const TextStyle(fontSize: kSmallFont))),
  );

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

  Widget get _buildAvatar => Container(
      decoration: BoxDecoration(border: Border.all(color: kBorderColor, width: 3.toPadding), shape: BoxShape.circle),
      child: ClipOval(
          child: buildNetImage(QiniuService.shared
              .fetchCustomImageUrl(key: controller.user.info.avatar, width: avatarWidth.toInt(), crop: true))));

  Widget _buildPetImage(Pet pet) =>
      CircleAvatarButton(url: pet.avatar.to200PxImageUrl, size: 24.toPadding, onTap: () => controller.onTapPet(pet));

  Widget _buildTitle(String text) =>
      Text(text, style: const TextStyle(fontSize: 10, color: kSecondaryTextColor, backgroundColor: kShapeColor));
}

class LoginUserCenterHeader extends UserCenterHeader<LoginUserCenterController> {
  LoginUserCenterHeader({Key? key, required super.height}) : super(key: key);

  @override
  Widget get _buildAvatar => PuppyAvatarButton(
      didSelected: controller.onSelectedAvatar,
      defaultAvatar: QiniuService.shared
          .fetchCustomImageUrl(key: controller.user.info.avatar, width: avatarWidth.toInt(), crop: true));

  @override
  Widget get _actionButton => PuppyButton(
    buttonStyle: ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: kSpacePadding))),
    onPressed: controller.onTapEdit,
    style: PuppyButtonStyle.style3,
    child: const Text('编辑资料', style: TextStyle(fontSize: kSmallFont)),
  );
}
