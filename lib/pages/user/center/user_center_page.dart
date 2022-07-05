import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/user/center/user_center_controller.dart';
import 'package:frontend/pages/user/center/user_center_post_list.dart';
import 'package:frontend/pages/user/center/views/user_center_bar.dart';
import 'package:frontend/pages/user/center/views/user_center_header.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class UserCenterPage extends StatefulWidget {
  const UserCenterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserCenterState<UserCenterPage, UserCenterController>();
}

class LoginUserCenterPage extends StatefulWidget {
  const LoginUserCenterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginUserCenterState();
}

class _UserCenterState<P extends StatefulWidget, C extends UserCenterController> extends State<P>
    with SingleTickerProviderStateMixin, LoadImageMixin {
  final _expandedHeight = 250.toPadding;
  final _tabs = ['动态'];
  final _scrollController = ScrollController();
  final _appBarOpacity = 0.0.obs;
  final _avatarWidth = 30.toPadding;
  late TabController _tabController;

  UserCenterController get controller => Get.find<C>();

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _scrollController.addListener(() {
      _appBarOpacity.value = min(_scrollController.offset / (_expandedHeight - kToolbarHeight), 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kShapeColor,
      body: controller.obx(
        (_) => NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (_, __) => [_appBar, _tabBar],
          body: TabBarView(controller: _tabController, children: const [CenterPostListPage()]),
        ),
      ),
    );
  }

  SliverAppBar get _appBar => SliverAppBar(
      title: Obx(
        () => Opacity(
            opacity: _appBarOpacity.value,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ClipOval(
                  child: buildNetImage(controller.user.info.avatarUrl, width: _avatarWidth, height: _avatarWidth)),
              SizedBox(width: 5.toPadding),
              Text(controller.user.info.nickname)
            ])),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(color: Colors.white),
      foregroundColor: Colors.white,
      leading: Obx(
          () => BackButton(color: ColorTween(begin: Colors.white, end: Colors.black).transform(_appBarOpacity.value))),
      actions: [
        Obx(() => IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz,
                color: ColorTween(begin: Colors.white, end: Colors.black).transform(_appBarOpacity.value))))
      ],
      floating: true,
      pinned: true,
      expandedHeight: _expandedHeight,
      flexibleSpace: FlexibleSpaceBar(background: flexibleSpaceBar));

  SliverPersistentHeader get _tabBar => SliverPersistentHeader(delegate: UserCenterBarDelegate(_tabController));

  Widget get flexibleSpaceBar => UserCenterHeader(height: flexibleSpaceBarHeight);

  double get flexibleSpaceBarHeight => _expandedHeight + Get.mediaQuery.viewPadding.top;
}

class _LoginUserCenterState extends _UserCenterState<LoginUserCenterPage, LoginUserCenterController> {
  @override
  Widget get flexibleSpaceBar => LoginUserCenterHeader(height: flexibleSpaceBarHeight);
}
