import 'package:flutter/material.dart';
import 'package:frontend/components/extension/image_extension.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/pet/pet_category.dart';
import 'package:frontend/models/id_name.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:get/get.dart';

part 'package:frontend/pages/user/pet/pet_category_controller.dart';

class PetCategoryPage extends GetView<PetCategoryController> with LoadImageMixin, ThemeMixin {
  PetCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('选择品种')),
      body: SafeArea(
        child: Column(children: [_searchBar, Expanded(child: _content)]),
      ),
    );
  }

  Widget get _searchBar {
    const border = OutlineInputBorder(borderSide: BorderSide(color: kShapeColor, width: 1));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSpacePadding),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => controller.search(),
        controller: controller.searchCtl,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            hintText: '搜索宠物品种',
            prefixIcon: Icon(Icons.search, color: kGreyColor),
            focusedBorder: border,
            enabledBorder: border),
      ),
    );
  }

  Widget get _content => Obx(() => CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSpacePadding),
            sliver: _headerItem,
          ),
          SliverToBoxAdapter(child: Divider(height: kSpacePadding, thickness: kSpacePadding)),
          SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(_itemBuilder, childCount: controller.searchResult.length)))
        ],
      ));

  Widget _itemBuilder(context, index) => ListTile(
      onTap: () => controller.choseCategory(controller.category.subCategory[index]),
      title: Text(controller.searchResult[index].name),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact);

  SliverToBoxAdapter get _headerItem => SliverToBoxAdapter(
        child: Wrap(
            spacing: kSpacePadding,
            runSpacing: kSpacePadding,
            children: controller.hotSubCategories.map(_hotCategoryBuilder).toList()),
      );

  Widget _hotCategoryBuilder(PetSubCategory sub) => GestureDetector(child:
      LayoutBuilder(
        builder: (_, constraints) => SizedBox(
            width: ((constraints.maxWidth - 3 * kSpacePadding) ~/ 4).toDouble(),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.toPadding),
                      child: buildNetImage(sub.image.toImageResourceUrl, fit: BoxFit.cover)),
                ),
                SizedBox(height: 5.toPadding),
                Text(sub.name)
              ],
            )),
      ), onTap: () => controller.choseCategory(sub));
}
