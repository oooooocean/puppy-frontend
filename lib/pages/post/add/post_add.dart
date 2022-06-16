import 'package:flutter/material.dart';
import 'package:frontend/components/comps/puppy_photo_picker.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/post/add/post_add_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostAddPage extends GetView<PostAddController> {
  const PostAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
        child: Column(children: [_chosePhotoItem]),
      )),
    );
  }

  AppBar get _appBar => AppBar(
      leading: const CloseButton(),
      actions: [
        TextButton(onPressed: controller.onPublish, child: const Text('发布', style: TextStyle(color: kOrangeColor)))
      ],
      elevation: 0);

  Widget get _chosePhotoItem => PuppyPhotoPicker(limit: 9);
}
