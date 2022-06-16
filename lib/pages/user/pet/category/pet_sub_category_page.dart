import 'dart:math';

import 'package:frontend/components/comps/header_list_page.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/extension/image_extension.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/models/id_name.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

part 'package:frontend/pages/user/pet/category/pet_sub_category_controller.dart';

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
          _searchHeaderView,
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10), child: _listView))
        ])));
  }

  Widget get _searchHeaderView => GestureDetector(
      onTap: () => controller.jumpToSearch(),
      child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: kBackgroundColor,
                border: Border.all(color: kBorderColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(20.toPadding))),
            height: 40.toPadding,
            child: Row(children: const [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.search, key: ValueKey("search")),
              ),
              Expanded(
                  child: Text(
                "搜索宠物品种",
                style: TextStyle(color: kSecondaryTextColor),
              ))
            ]),
          )));

  Widget get _listView => GetBuilder<PetSubCategoryController>(builder: (_) {
        if (controller.category.subCategory.isEmpty) {
          return ListView.builder(
              itemBuilder: _itemBuilder,
              itemCount: controller.category.subCategory.length);
        }
        return HeaderListPage(controller.category.subCategory,
            itemWidgetCreator: _itemBuilder, headerCreator: _headerCreator);
      });

  Widget _itemBuilder(context, index) => GestureDetector(
      child: Column(
        children: [
          ListTile(title: Text(controller.category.subCategory[index].name)),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(color: kBorderColor, height: 1.toPadding))
        ],
      ),
      onTap: () => controller.choseCategory(index));

  Widget _headerCreator(context, index) => SizedBox(
      height: max(100,
          min(((controller.hotSubCategories?.length ?? 0) ~/ 4) * 100, 200)),
      child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.hotSubCategories?.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10.0, mainAxisSpacing: 10.0, crossAxisCount: 4),
          itemBuilder: _gridContent));

  Widget _gridContent(context, index) => Column(
        children: [
          SizedBox(
              height: 60,
              width: 60,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: _imageView(index))),
          const SizedBox(height: 10),
          Text(controller.hotSubCategories![index].name)
        ],
      );

  Widget _imageView(int index) => GestureDetector(
      child: controller.loadHotImage(index) == null
          ? const AspectRatio(
              aspectRatio: 1,
              child: Icon(Icons.camera_alt_rounded, color: kSecondaryTextColor))
          : buildNetImage(controller.loadHotImage(index)!, fit: BoxFit.fill),
      onTap: () => controller.choseHotCategory(index));
}
