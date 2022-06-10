import 'package:frontend/components/comps/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:get/get.dart';

part 'package:frontend/pages/user/pet/pet_search_controller.dart';

class PetSearchPage extends GetView<PetSearchController>
    with LoadImageMixin, ThemeMixin {
  PetSearchPage({Key? key}) : super(key: key);

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
          AnimatedSearchBar(
            height: 40,
            label: "选择宠物品种",
            onChanged: (text) {
              controller.search(text);
            },
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10), child: _listView))
        ])));
  }

  Widget get _listView => GetBuilder<PetSearchController>(
      id: "list",
      builder: (_) => ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: controller.searchedList.length));

  Widget _itemBuilder(context, index) => GestureDetector(
      child: Column(
        children: [
          ListTile(title: Text(controller.searchedList[index].name)),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: kBorderColor,
              ))
        ],
      ),
      onTap: () => controller.choseCategory(index));
}
