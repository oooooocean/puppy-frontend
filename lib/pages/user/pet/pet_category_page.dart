import 'package:flutter/material.dart';
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
        appBar: AppBar(title: const Text('选择分类')),
        body: SafeArea(
            child: GetBuilder<PetCategoryController>(
                builder: (_) => GridView.builder(
                    itemCount: controller.categories.length,
                    itemBuilder: _gridContent,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2)))));
  }

  Widget _gridContent(context, index) => GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.petSubCategory,
            arguments: controller.categories[index]);
      },
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: kBorderColor)),
        child: Column(children: [
          // buildNetImage(
          //     controller.categories[index].subCategory.first.image),
          // const SizedBox(height: 12),
          Text(controller.categories[index].name)
        ]),
      ));
}
