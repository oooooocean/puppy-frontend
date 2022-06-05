import 'package:frontend/components/comps/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:get/get.dart';
part 'package:frontend/pages/user/pet/pet_sub_category_controller.dart';

class PetSubCategoryPage extends GetView<PetSubCategoryController>
    with LoadImageMixin, ThemeMixin {
  PetSubCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('选择品种')),
        body: SafeArea(
            child: Column(children: [
          SAppBarSearch(height: 40, hintText: "选择宠物品种"),
          Expanded(child: _listView)
        ])));
  }

  Widget get _listView => GetBuilder<PetSubCategoryController>(builder: (_) {
        return ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: controller.category.subCategory.length);
      });

  Widget _itemBuilder(context, index) => GestureDetector(
        child:
            ListTile(title: Text(controller.category.subCategory[index].name)),
        onTap: () => controller.choseCategory(index),
      );
}
