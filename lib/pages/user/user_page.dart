import 'package:flutter/material.dart';
import 'package:frontend/components/abstract/scaffold_child_state.dart';
import 'package:frontend/pages/user/user_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserState();
}

class _UserState extends ScaffoldChildState<UserPage, UserController> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [IconButton(onPressed: () => Get.toNamed(AppRoutes.userSetting), icon: const Icon(Icons.settings))],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
