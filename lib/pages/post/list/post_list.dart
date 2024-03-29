import 'package:flutter/material.dart';
import 'package:frontend/components/abstract/scaffold_child_state.dart';
import 'package:frontend/pages/post/list/post_list_controller.dart';
import 'package:frontend/pages/post/views/post_list_tile.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostListState();
}

class _PostListState extends ScaffoldChildState<PostListPage, PostListController> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<PostListController>(
      builder: (_) => SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        child: ListView.separated(
            itemBuilder: _itemBuilder, separatorBuilder: _separatorBuilder, itemCount: controller.items.length),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final post = controller.items[index];
    return PostListTile<PostListController>(post: post, onTap: controller.onTapPost);
  }

  Widget _separatorBuilder(BuildContext context, int index) => Divider(height: 5.toPadding, thickness: 5.toPadding);
}
