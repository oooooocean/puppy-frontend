
import 'package:frontend/pages/login/password/password_controller.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:frontend/route/pages.dart';

class FlowStep {
  final String name;
  final StepState state;
  FlowStep(this.name, this.state);
}

extension IFlowStep on LaunchServiceFlow {
  static List<FlowStep> steps() {
    final curIndex = LaunchService.shared.currentRegisterFlow?.index ?? 0;
    return LaunchServiceFlow.values
        .map((e) => FlowStep(e.name,
        curIndex >= e.index ? StepState.complete : StepState.indexed))
        .toList();
  }
}

class LaunchServiceController extends GetxController {

  RxInt? currentStep = LaunchService.shared.currentRegisterFlow?.index.obs;
  final steps = IFlowStep.steps();
  var currentFlow = LaunchService.shared.currentRegisterFlow.obs;
  final fromOther = Get.previousRoute.isNotEmpty && (!LaunchServiceFlow.passwordSet.previousRoutes.contains(Get.previousRoute));
  get hasSkip => !fromOther && (LaunchService.shared.currentRegisterFlow != LaunchServiceFlow.userInfoAdd);

  @override
  void onInit() {
    super.onInit();

    Get.lazyPut(() => PasswordController(PasswordStyle.set));
  }

  stepContinue() {
    if (currentStep!.value == 2) {
      return;
    }
    currentStep!.value ++;
  }

  skip() {
    final next = LaunchServiceFlow.passwordSet.nextRoute;
    next != null ? Get.toNamed(next) : Get.offAllNamed(AppRoutes.scaffold);
  }
}