import 'package:flutter/material.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';

class PostTopicListController extends GetxController with NetMixin, StateMixin<List<PostTopic>> {
  final searchCtl = TextEditingController();
  var searchResult = RxList<PostTopic>();

  onSearch(String keyword) {
    final origin = state!;
    searchResult.value = origin.where((element) => element.title.contains(keyword)).toList();
  }

  @override
  void onReady() {
    change(null, status: RxStatus.loading());
    get('post/topics/', (data) => (data as List<dynamic>).map((e) => PostTopic.fromJson(e)).toList()).then((value) {
      change(value, status: RxStatus.success());
      searchResult.value = value;
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onReady();
  }
}
