import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/home/home_page.dart';
import 'package:frontend/pages/post/list/post_list.dart';
import 'package:frontend/pages/scaffold/scaffold_controller.dart';
import 'package:frontend/pages/scaffold/scaffold_item.dart';
import 'package:frontend/pages/user/user_page.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<ScaffoldPage> with ThemeMixin, SingleTickerProviderStateMixin {
  late TabController _tabCtl;

  ScaffoldController get controller => Get.find<ScaffoldController>();

  @override
  void initState() {
    _tabCtl = TabController(length: ScaffoldItem.values.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.toPadding,
        child: SizedBox(
          height: 49,
          child: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              indicator: const BoxDecoration(),
              indicatorWeight: 0,
              controller: _tabCtl,
              labelColor: kOrangeColor,
              unselectedLabelColor: Colors.grey,
              tabs: ScaffoldItem.values
                  .map((e) =>
                      Tab(iconMargin: EdgeInsets.only(bottom: 5.toPadding), text: e.toString(), icon: Icon(e.iconData)))
                  .toList()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        onPressed: () => Get.toNamed(AppRoutes.postAdd),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: TabBarView(
          controller: _tabCtl, physics: const NeverScrollableScrollPhysics(), children: const [HomePage(), UserPage()]),
    );
  }
}
