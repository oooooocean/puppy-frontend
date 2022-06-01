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
      body: Center(
        child: TextButton(onPressed: () => Get.toNamed(AppRoutes.userInfoEdit), child: const Text('编辑用户资料')),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
