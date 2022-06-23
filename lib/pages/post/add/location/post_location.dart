import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/post/add/location/post_location_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostLocationPage extends GetView<PostLocationController> {
  const PostLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('选择位置', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    PuppyButton(style: PuppyButtonStyle.style3, onPressed: () => Get.back(), child: const Text('取消'))
                  ],
                ),
                TextField(
                  controller: controller.searchCtl,
                  onChanged: (keyword) {},
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: '搜索附近地点',
                      enabledBorder: InputBorder.none,
                      fillColor: kShapeColor,
                      filled: true),
                ),
                Expanded(
                  child: GetBuilder<PostLocationController>(
                    id: 'location',
                    builder: (_) => SmartRefresher(
                      controller: controller.refreshController,
                      onRefresh: controller.onLoading,
                      child: ListView.builder(itemBuilder: _itemBuilder, itemCount: controller.searchResult.length),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final poi = controller.searchResult[index];
    return ListTile(
        onTap: () => controller.onTap(index),
        contentPadding: EdgeInsets.zero,
        title: Text(poi.name ?? ''),
        subtitle: poi.addr == null ? null : Text(poi.addr ?? ''),
        visualDensity: VisualDensity.compact);
  }
}
