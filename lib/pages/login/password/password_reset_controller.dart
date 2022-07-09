import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/components/mixins/validator.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';

class PasswordResetController extends GetxController with NetMixin {
  final oldPwdCtl = TextEditingController();
  final newPwdCtl = TextEditingController();

  /// 是否可保存
  var saveEnable = false.obs;

  bool get shouldSavePassword =>
      Validator.password.verify(oldPwdCtl.text) &&
      Validator.password.verify(newPwdCtl.text);

  save() {
    final user = LaunchService.shared.user;
    assert(user != null, '必须登录');
    request<bool>(
        api: () => post('user/${user!.id}/password/reset/',
            {'old': oldPwdCtl.text, "new": newPwdCtl.text}, (data) => true),
        success: (_) {
          EasyLoading.showSuccess("重置成功");
          Get.back();
        });
  }
}
