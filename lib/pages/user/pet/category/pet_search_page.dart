import 'package:frontend/components/comps/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:get/get.dart';

part 'package:frontend/pages/user/pet/category/pet_search_controller.dart';

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
            title: AnimatedSearchBar(
              label: "点击开始搜索",
              searchDecoration: const InputDecoration(
                  hintText: "搜索宠物品种",
                  alignLabelWithHint: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gapPadding: 4)),
              height: 30,
              onChanged: (text) {
                controller.search(text);
              },
            )),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(top: 10), child: _contentView)));
  }

  Widget get _contentView => GetBuilder<PetSearchController>(
      id: "list",
      builder: (_) => controller.searchedList.isEmpty && controller.hasSearched
          ? _emptyView
          : _listView);

  Widget get _emptyView => Center(
          child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
            children: const [Icon(Icons.hourglass_empty), Text("未找到品种")]),
      ));

  Widget get _listView => ListView.builder(
      itemBuilder: _itemBuilder, itemCount: controller.searchedList.length);

  Widget _itemBuilder(context, index) => GestureDetector(
      child: Column(
        children: [
          ListTile(title: Text(controller.searchedList[index].name)),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(color: kBorderColor, height: 1.toPadding))
        ],
      ),
      onTap: () => controller.choseCategory(index));
}
