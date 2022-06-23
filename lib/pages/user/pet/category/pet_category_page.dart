import 'package:flutter/material.dart';
import 'package:frontend/components/extension/image_extension.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

part 'package:frontend/pages/user/pet/category/pet_category_controller.dart';

class PetCategoryPage extends GetView<PetCategoryController> with LoadImageMixin {
  PetCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('选择分类')),
      body: SafeArea(
        child: GridView.builder(
            padding: EdgeInsets.only(top: 20.toPadding, left: 40.toPadding, right: 40.toPadding),
            itemCount: controller.categories.length,
            itemBuilder: _itemBuilder,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10.toPadding, mainAxisSpacing: 10.toPadding, crossAxisCount: 2)),
      ),
    );
  }

  Widget _itemBuilder(context, index) => GestureDetector(
    onTap: () => controller.jumpToSub(index),
    child: Column(
          children: [
            SizedBox(height: 100.toPadding, width: 100.toPadding, child: ClipOval(child: _imageView(index))),
            SizedBox(height: kSpacePadding),
            Text(controller.categories[index].name)
          ],
        ),
  );

  Widget _imageView(int index) => buildNetImage(controller.loadImage(index), fit: BoxFit.fill);
}
