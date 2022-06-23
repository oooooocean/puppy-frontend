import 'package:frontend/net/net_mixin.dart';
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
}
