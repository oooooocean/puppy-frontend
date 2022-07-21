import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/login/launch_service_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class LaunchServicePage extends GetView<LaunchServiceController> with ThemeMixin {

  LaunchServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: WillPopScope(
        child: _body,
        onWillPop: () async => controller.fromOther,
      ),
    );
  }

  AppBar get _appBar => AppBar(
    automaticallyImplyLeading: controller.fromOther,
    title: const Text('设置密码'),
    actions: controller.fromOther
        ? null
        : [
      TextButton(
          onPressed: controller.skip, child: const Text('跳过', style: TextStyle(color: kSecondaryTextColor)))
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
            currentStep: controller.currentStep!.value,
            type: StepperType.horizontal,
            steps: controller.steps
                .map((e) => Step(
                title: Text(e.name),
                content: const Text(''),
                state: e.state))
                .toList())),
      ),
      const Expanded(child: Text('后续完善流程'))
    ],
  );

}
