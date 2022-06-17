import 'package:flutter/material.dart';
import 'package:frontend/components/abstract/scaffold_child_state.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/home/home_controller.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/pages/post/list/post_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends ScaffoldChildState<HomePage, HomeController> with SingleTickerProviderStateMixin {
  late TabController _tabCtl;

  @override
  void initState() {
    _tabCtl = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 140,
            child: TabBar(
                indicatorPadding: EdgeInsets.only(bottom: 10.toPadding),
                labelColor: kOrangeColor,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                unselectedLabelColor: kSecondaryTextColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: kOrangeColor,
                controller: _tabCtl,
                tabs: ['星球', '乐园'].map((e) => Tab(text: e)).toList()),
          ),
        ),
        body: TabBarView(controller: _tabCtl, children: [
          PostListPage(),
          Center(child: Text('2')),
        ]));
  }

  @override
  bool get wantKeepAlive => true;
}
