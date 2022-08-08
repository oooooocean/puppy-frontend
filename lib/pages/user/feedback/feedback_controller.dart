import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/services/store.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

extension FeedbackStore on FeedbackController {
  static const saveKey = 'feedback';

  /// 是否允许反馈
  /// 每天最多反馈一次
  /// TODO: 测试
  static Future<bool> shouldFeedback() async {
    final lastString = await Store.get(saveKey);
    if (lastString == null) return true;
    final last =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(lastString) * 1000);
    final now = DateTime.now();
    return now.subtract(const Duration(hours: 24)).isAfter(last);
  }
}

class FeedbackController extends GetxController with NetMixin {
  final feedbackCtl = TextEditingController();

  var selectCategory = ''.obs;

  List<String> reasonCategories = [
    '功能问题：功能故障',
    '体验问题：我有建议',
    '安全问题：密码、隐私',
    '其他问题'
  ];

  var images = RxList<AssetEntity>();

  final assetLimit = 2;

  bool get shouldNext =>
      feedbackCtl.text.isNotEmpty && selectCategory.value.isNotEmpty;

  void choseImage() async {
    final config = AssetPickerConfig(
        selectedAssets: images,
        maxAssets: assetLimit,
        requestType: RequestType.image);
    final results =
        await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    images.value = results;
  }

  void selectTile(String selected) {
    selectCategory.value = selected;
    update(['next']);
  }

  /// 意见反馈请求
  void feedbackRequest() {
    request(
        api: () => uploadImages(images).then((images) => post(
            'feedback/',
            {
              'title': selectCategory.value,
              'description': feedbackCtl.text,
              'medias': images.map((e) => e.toJson()).toList()
            },
            (data) => data)),
        success: (_) {
          Store.set(FeedbackStore.saveKey,
              (DateTime.now().microsecondsSinceEpoch ~/ 1000).toString());
          EasyLoading.showToast('已提交成功，感谢您的建议');
          Get.back();
        });
  }
}
