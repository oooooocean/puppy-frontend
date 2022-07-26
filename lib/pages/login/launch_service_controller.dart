
import 'package:frontend/pages/login/password/password_controller.dart';
import 'package:frontend/pages/user/info/user_add_controller.dart';
import 'package:frontend/pages/user/pet/pet_add_controller.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FlowStep {
  final String name;
  final StepState state;
  FlowStep(this.name, this.state);
}

extension IFlowStep on LaunchServiceFlow {
  static List<FlowStep> steps(LaunchServiceFlow? flow) =>
      LaunchServiceFlow.values
          .map((e) => FlowStep(
              e.name,
              (flow?.index ?? 0) >= e.index
                  ? StepState.complete
                  : StepState.indexed))
          .toList();
}

class LaunchServiceController extends GetxController {
  final fromOther = Get.previousRoute.isNotEmpty && (!LaunchServiceFlow.passwordSet.previousRoutes.contains(Get.previousRoute));
  var currentFlow = LaunchService.shared.currentRegisterFlow.obs;
  get hasSkip => !fromOther && (LaunchService.shared.currentRegisterFlow != LaunchServiceFlow.userInfoAdd);
  List<FlowStep> get steps => IFlowStep.steps(currentFlow.value);

  @override
  void onInit() {
    super.onInit();

    Get.lazyPut(() => UserAddController());
    Get.lazyPut(() => PasswordController(PasswordStyle.set));
    Get.lazyPut(() => PetAddController());
  }

  stepContinue() {
    if (currentFlow.value!.index == LaunchServiceFlow.values.length) return;
    currentFlow.value = currentFlow.value!.nextFlow;
  }

}