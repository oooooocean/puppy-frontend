import 'package:frontend/components/comps/search_bar.dart';
import 'package:frontend/components/comps/header_list_page.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/models/id_name.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:get/get.dart';
part 'package:frontend/pages/user/pet/pet_sub_category_controller.dart';

class PetSubCategoryPage extends GetView<PetSubCategoryController>
    with LoadImageMixin, ThemeMixin {
  PetSubCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              onPressed: () => Get.back(),
              color: kBlackColor,
            ),
            title: const Text('选择品种')),
        body: SafeArea(
            child: Column(children: [
          SAppBarSearch(height: 40, hintText: "选择宠物品种"),
          Expanded(child: _listView)
        ])));
  }

  Widget get _listView => GetBuilder<PetSubCategoryController>(builder: (_) {
        if (controller.category.subCategory.length < 4) {
          return ListView.builder(
              itemBuilder: _itemBuilder,
              itemCount: controller.category.subCategory.length);
        }
        return HeaderListPage(controller.category.subCategory,
            itemWidgetCreator: _itemBuilder,
            headerList: controller.hotSubCategories,
            headerCreator: _headerCreator);
      });

  Widget _itemBuilder(context, index) => GestureDetector(
        child:
            ListTile(title: Text(controller.category.subCategory[index].name)),
        onTap: () => controller.choseCategory(index),
      );

  Widget _headerCreator(context, index) => GestureDetector(
        child:
            ListTile(title: Text(controller.hotSubCategories?[index].name ?? "")),
        onTap: () => controller.choseCategory(index),
      );
}
