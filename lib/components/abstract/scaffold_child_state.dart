import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ScaffoldChildState<P extends StatefulWidget, C extends GetxController> extends State<P>
    with AutomaticKeepAliveClientMixin {
  C get controller => Get.find<C>();

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  bool get wantKeepAlive => true;
}
