import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/user/center/center_controller.dart';
import 'package:frontend/pages/user/center/views/user_center_header.dart';
import 'package:get/get.dart';
import 'package:frontend/components/extension/int_extension.dart';

class CenterPage extends GetView<CenterController> with LoadImageMixin {
  final expandedHeight = 250.toPadding;

  CenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kShapeColor, body: controller.obx((_) => CustomScrollView(slivers: [_appBar])));
  }

  SliverAppBar get _appBar => SliverAppBar(
        foregroundColor: Colors.white,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz, color: Colors.white))],
        floating: true,
        pinned: true,
        expandedHeight: expandedHeight,
        flexibleSpace:
            FlexibleSpaceBar(background: UserCenterHeader(height: expandedHeight + Get.mediaQuery.viewPadding.top)),
      );
}
