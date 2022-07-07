import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'idol_list_controller.dart';

class IdolListPage extends GetView<IdolListController> {
  const IdolListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
          child: Column(
            children: [
              _headerItem,
              TextField(
                controller: controller.searchCtl,
                onChanged: (keyword) {},
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                    // constraints: BoxConstraints.tightFor(height: 44),
                    prefixIcon: Icon(Icons.search),
                    hintText: '搜索用户',
                    enabledBorder: InputBorder.none,
                    fillColor: kShapeColor,
                    filled: true),
              ),
              const Divider(),
              Expanded(child: _list)
            ],
          ),
        ),
      ),
    );
  }

  Widget get _list => GetBuilder<IdolListController>(
        builder: (_) => SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: false,
            enablePullUp: true,
            onLoading: () => controller.startRefresh(RefreshType.loadMore).then((value) => controller.update()),
            child: ListView.separated(
                itemBuilder: _itemBuilder,
                separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1),
                itemCount: controller.items.length)),
      );

  Widget _itemBuilder(BuildContext context, int index) {
    final user = controller.items[index];
    return ListTile(
        onTap: () => Get.back(result: user),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: CircleAvatarButton(onTap: () {}, url: user.info.avatarUrl),
        title: Text(user.info.nickname),
        visualDensity: VisualDensity.compact,
        trailing: PuppyButton(
            style: PuppyButtonStyle.style3,
            child: const Text('已关注', style: TextStyle(fontSize: kSmallFont)),
            onPressed: () {}));
  }

  Widget get _headerItem => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('发布提醒', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          PuppyButton(style: PuppyButtonStyle.style3, onPressed: () => Get.back(), child: const Text('取消'))
        ],
      );
}
