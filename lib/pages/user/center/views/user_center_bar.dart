import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';

class UserCenterBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final _tabs = ['动态'];

  UserCenterBarDelegate(this.tabController);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => TabBar(
        tabs: _tabs.map((e) => Tab(text: e)).toList(),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: kOrangeColor,
        labelColor: kPrimaryTextColor,
        unselectedLabelColor: kGreyColor,
        indicatorPadding: const EdgeInsets.only(bottom: 10),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        isScrollable: true,
      );

  @override
  double get maxExtent => 46.0;

  @override
  double get minExtent => 46.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration {
    return const PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: double.infinity,
    );
  }
}
