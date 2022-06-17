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
          Expanded(child: Column(children: [_chosePhotoItem, _descriptionItem])),
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
              onPress: controller.shouldRequest ? controller.onPublish : null,
              child: const Text('发布', style: TextStyle(fontWeight: FontWeight.bold))),
        )
      ],
      elevation: 0);

  Widget get _chosePhotoItem =>
      PuppyAssetsPicker(limit: 9, assetsChanged: (assets) {
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

  Widget get _actionBar => const PostAddActionBar();
}
