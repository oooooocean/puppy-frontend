import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/user/setting/setting_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/components/extension/int_extension.dart';
class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kShapeColor,
      appBar: AppBar(title: const Text('设置')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListTile(
                title: const Text('意见反馈'),
                onTap:controller.feedback ,
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
             Divider(height: 1,indent: 15.toPadding,endIndent: 15.toPadding,),
            TextButton(
                onPressed: controller.logout,
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(Get.width, 50.toPadding)),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                child: const Text('离开星球', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red)))
          ],
        ),
      ),
    );
  }
}
