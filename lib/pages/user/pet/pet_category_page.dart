import 'package:flutter/material.dart';
import 'package:frontend/components/extension/image_extension.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
part 'package:frontend/pages/user/pet/pet_category_controller.dart';

class PetCategoryPage extends GetView<PetCategoryController>
    with LoadImageMixin, ThemeMixin {
  PetCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              onPressed: () => Get.back(),
              color: kBlackColor,
            ),
            title: const Text('选择分类')),
        body: SafeArea(
            child: GetBuilder<PetCategoryController>(
                builder: (_) => Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 40, right: 40),
                    child: GridView.builder(
                        itemCount: controller.categories.length,
                        itemBuilder: _gridContent,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                crossAxisCount: 2))))));
  }

  Widget _gridContent(context, index) => Column(
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: ClipOval(child: _imageView(index))),
          const SizedBox(height: 12),
          Text(controller.categories[index].name)
        ],
      );

  Widget _imageView(int index) => GestureDetector(
      child: controller.loadImage(index) == null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(Icons.camera_alt_rounded,
                  size: 40, color: kSecondaryTextColor))
          : buildNetImage(controller.loadImage(index)!, fit: BoxFit.fill),
      onTap: () => controller.jumpToSub(index));
}
