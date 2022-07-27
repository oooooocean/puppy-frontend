import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/login/launch_service_controller.dart';
import 'package:frontend/pages/login/password/password_set_page.dart';
import 'package:frontend/pages/user/info/user_add_page.dart';
import 'package:frontend/pages/user/pet/pet_add_page.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:frontend/pages/user/info/user_add_controller.dart';
import 'package:frontend/route/pages.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class LaunchServicePage extends GetView<LaunchServiceController>
    with ThemeMixin {
  LaunchServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _appBar,
      body: WillPopScope(
        child: _body,
        onWillPop: () async => controller.fromOther,
      ),
    ));
  }

  AppBar get _appBar => AppBar(
        automaticallyImplyLeading: controller.fromOther,
        title: Obx(() => Text('${controller.currentFlow.value?.name}')),
        actions: [
          Obx(() => TextButton(
              onPressed: !controller.hasSkip
                  ? null
                  : () => Get.offAllNamed(AppRoutes.scaffold),
              child: !controller.hasSkip
                  ? const Text('')
                  : const Text('跳过',
                      style: TextStyle(color: kSecondaryTextColor))))
        ],
      );

  Widget get _body => Column(
        children: [
          SizedBox(
            height: 100.toPadding,
            child: Obx(() => Stepper(
                controlsBuilder: (_, details) => Row(
                      children: const [],
                    ),
                onStepContinue: controller.stepContinue,
                currentStep: controller.currentFlow.value!.index,
                type: StepperType.horizontal,
                steps: controller.steps
                    .map((e) => Step(
                        title: Text(e.name),
                        content: const Text(''),
                        state: e.state))
                    .toList())),
          ),
          Expanded(child: Obx(() => _content!))
        ],
      );

  Widget? get _content {
    if (controller.currentFlow.value == null) return null;
    switch (controller.currentFlow.value!) {
      case LaunchServiceFlow.passwordSet:
        return PasswordSetPage();
      case LaunchServiceFlow.userInfoAdd:
        return UserAddPage<UserAddController>();
      case LaunchServiceFlow.petAdd:
        return PetAddPage();
    }
  }
}
