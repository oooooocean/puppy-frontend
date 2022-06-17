import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/services/store.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class FeedbackController extends GetxController with NetMixin {

  final feedbackCtl = TextEditingController();

  var selectCategory = ''.obs;

  List<String> reasonCategories = ['功能问题：功能故障', '体验问题：我有建议', '安全问题：密码、隐私', '其他问题'];

  List<AssetEntity> images = [];

  var maxAssets = 2;

  bool get shouldNext => feedbackCtl.text.isNotEmpty && selectCategory.value.isNotEmpty ;

  void choseImage() async {
    final config = AssetPickerConfig(
        selectedAssets: images.length == maxAssets ? images : null,
        maxAssets: maxAssets - images.length,
        requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    images.isEmpty && results.length == maxAssets ? images = results : images.add(results.first);
    update(['image']);
  }

  void selectTile(String selected) {
    selectCategory.value = selected;
  }

  /// 意见反馈请求

  void feedbackRequest() {
    Future? api = uploadImages(images).then((images) => post(
        'feedback/',
        {
          'title': selectCategory.value,
          'description': feedbackCtl.text,
          'medias': images.map((e) => {'type': 0, 'key': e}).toList()
        }, (data) => data));

    request(
        api: api,
        success: (_) {
          StoreDate.setCurrentDateOfYYMMDD('feedback');
          EasyLoading.showToast('已提交成功，感谢您的建议');
          Get.back();
        });
  }


}