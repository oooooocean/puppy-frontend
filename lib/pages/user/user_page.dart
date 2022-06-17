import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/components/abstract/scaffold_child_state.dart';
import 'package:frontend/pages/user/feedback/feedback_page.dart';
import 'package:frontend/pages/user/user_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/store.dart';
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
      appBar: AppBar(title: Text('hello'),),
      body: Center(
        child: TextButton(onPressed: () => Get.toNamed(AppRoutes.userInfoEdit), child: const Text('编辑用户资料')),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'other',
        tooltip: 'feedback',
        onPressed: gotoFeedback,
        child: const Icon(Icons.feedback),
      ),
    );
  }

  void gotoFeedback() {
    StoreDate.isSubmitedFeedback().then((value){
      if(!value){
        EasyLoading.showToast("今天您已经提过建议啦，请明天再提");
      } else{
        Get.toNamed(AppRoutes.feedback);
      }
    });
  }
  @override
  bool get wantKeepAlive => true;
}
