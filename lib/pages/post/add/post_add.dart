import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/comps/puppy_photo_picker.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/post/add/post_add_controller.dart';
import 'package:frontend/pages/post/views/post_add_action_bar.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostAddPage extends GetView<PostAddController> {
  const PostAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
        child: Column(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_chosePhotoItem, _descriptionItem, _topicItem, _idolsItem, _addressItem])),
          _actionBar
        ]),
      )),
    );
  }

  AppBar get _appBar => AppBar(
      leading: const CloseButton(),
      actions: [
        GetBuilder<PostAddController>(
          id: 'publish',
          builder: (_) => PuppyButton(
              style: PuppyButtonStyle.style2,
              onPressed: controller.shouldRequest ? controller.onPublish : null,
              child: const Text('发布', style: TextStyle(fontWeight: FontWeight.bold))),
        )
      ],
      elevation: 0);

  Widget get _chosePhotoItem => PuppyAssetsPicker(
      limit: 9,
      assetsChanged: (assets) {
        controller.assets.value = assets;
        controller.update(['publish']);
      });

  Widget get _descriptionItem => TextField(
        controller: controller.descriptionCtl,
        maxLines: 5,
        maxLength: 200,
        onChanged: (_) => controller.update(['publish']),
        decoration: const InputDecoration(hintText: '不管我成为啥鬼姿态, 你从来都不会嫌弃我.\n\n分享快乐, 记录日常.'),
      );

  Widget get _topicItem => GetBuilder<PostAddController>(
      id: 'topic',
      builder: (_) => controller.topic == null
          ? Container()
          : _buildChipItem(controller.topic!.title, Icons.tag, controller.onTapTopic));

  Widget get _idolsItem => Obx(() {
        if (controller.idols.isEmpty) return Container();
        return Wrap(
            spacing: kSpacePadding,
            runSpacing: kSpacePadding,
            children: controller.idols
                .map((element) =>
                    _buildChipItem(element.info.nickname, Icons.alternate_email, controller.onTapIdols))
                .toList());
      });

  Widget get _actionBar => const PostAddActionBar();

  Widget get _addressItem => GetBuilder<PostAddController>(
      id: 'address',
      builder: (_) {
        if (controller.address == null) return Container();
        var description = controller.address?.first.city ?? '';
        if (controller.address?.second != null) {
          description += ' · ${controller.address?.second?.name}';
        }
        return _buildChipItem(description, Icons.location_on, controller.onTapMap);
      });

  Widget _buildChipItem(String text, IconData iconData, VoidCallback onPressed) => ActionChip(
      avatar: Icon(iconData, size: 20.toPadding, color: kOrangeColor),
      label: Text(text),
      labelPadding: EdgeInsets.only(right: kSpacePadding),
      padding: EdgeInsets.symmetric(horizontal: kSpacePadding),
      labelStyle: const TextStyle(color: kOrangeColor),
      backgroundColor: kShapeColor,
      visualDensity: VisualDensity.compact,
      pressElevation: 0,
      onPressed: onPressed);
}
