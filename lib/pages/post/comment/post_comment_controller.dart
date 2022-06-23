import 'package:flutter/cupertino.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';

class PostCommentController extends GetxController with NetMixin {
  final int postId;
  final commentCtl = TextEditingController();
  var enableComment = false.obs;

  PostCommentController(this.postId);

  onTapComment() {
    if (commentCtl.text.isEmpty) return;
    
    request(api: () => post('post/$postId/comments/', {'description': commentCtl.text}, (data) => true), success: (_) {
      Get.back(result: true);
    });
  }
}