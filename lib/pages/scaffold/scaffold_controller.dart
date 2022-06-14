import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:get/get.dart';

class ScaffoldController extends GetxController with NetMixin, StateMixin {
  @override
  void onReady() {
    change(null, status: RxStatus.loading());
    LaunchService.shared.refreshUserIfNeed()?.then((_) {
      change(null, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onReady();
  }
}
