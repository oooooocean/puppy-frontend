import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:get/get.dart';
import 'topic_list_controller.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostTopicListPage extends GetView<PostTopicListController> {
  const PostTopicListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: controller.obx(
          (state) => _content,
          onLoading: const CupertinoActivityIndicator(),
          onError: (msg) => Text(msg!),
        ),
      ),
    );
  }

  Widget get _content => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('添加话题', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                PuppyButton(style: PuppyButtonStyle.style3, onPressed: () => Get.back(), child: const Text('取消'))
              ],
            ),
            TextField(
              controller: controller.searchCtl,
              onChanged: (keyword) {},
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                  // constraints: BoxConstraints.tightFor(height: 44),
                  prefixIcon: Icon(Icons.search),
                  hintText: '搜索话题',
                  enabledBorder: InputBorder.none,
                  fillColor: kShapeColor,
                  filled: true),
            ),
            Expanded(child: ListView.builder(itemBuilder: _itemBuilder, itemCount: controller.searchResult.length))
          ],
        ),
      );

  Widget _itemBuilder(BuildContext context, int index) {
    final topic = controller.searchResult[index];
    return ListTile(
        onTap: () => Get.back(result: topic),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: const Icon(Icons.tag),
        title: Text(topic.title),
        visualDensity: VisualDensity.compact,
        trailing: Text('${topic.contentCount} 内容', style: const TextStyle(color: kSecondaryTextColor, fontSize: kSmallFont)));
  }
}
