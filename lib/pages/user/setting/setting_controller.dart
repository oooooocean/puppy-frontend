import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/pages/user/feedback/feedback_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';

class SettingController extends GetxController with NetMixin {
  logout() {
    request<bool>(
        api: () => post('user/logout/', {}, (data) => true),
        success: (_) {
          LaunchService.shared.restart();
        });
  }
  feedback() {
    FeedbackStore.shouldFeedback().then((value) {
      if(value) {
        Get.toNamed(AppRoutes.feedback);
      }else {
        EasyLoading.showToast("您今天已经反馈过了，请明天再来哦。");
      }

    });
  }
}
