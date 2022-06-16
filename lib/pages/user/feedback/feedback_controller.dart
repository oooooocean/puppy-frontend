import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class FeedbackController extends GetxController with NetMixin {
  final feedbackCtl = TextEditingController();

  var selectCategory = ''.obs;

  var feedbackEnable = false.obs;

  var isLimit = false.obs;

  List<String> reasonCategories = ['功能问题：功能故障', '体验问题：我有建议', '安全问题：密码、隐私', '其他问题'];

  List<AssetEntity> covers = [];

  var maxAssets = 2;

  @override
  onReady() {
    isSubmited()
        .then((value) => {
      if (value == true) {EasyLoading.showToast("今天您已经提过建议啦，请明天再提")}
    })
        .then((value) => {isLimit.value = true});

    super.onReady();
  }

  bool get shouldNext => feedbackCtl.text.isNotEmpty && selectCategory.value.isNotEmpty && !isLimit.value;

  void choseCover() async {
    final config = AssetPickerConfig(
        selectedAssets: covers.length == maxAssets ? covers : null,
        maxAssets: maxAssets - covers.length,
        requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    covers.isEmpty && results.length == maxAssets ? covers = results : covers.add(results.first);
    update(['cover']);
  }

  void selectCell(String selected) {
    selectCategory.value = selected;
    update(['listView', 'next']);
  }

  /// 意见反馈请求
  feedback() {
    isSubmited().then((value) => {
      if (value == true) {EasyLoading.showToast("今天您已经提过建议啦，请明天再提")} else {requestMethod()}
    });
  }

  void requestMethod() {
    Future? api = uploadImages(covers).then((images) => post(
        'feedback/',
        {
          'title': selectCategory.value,
          'description': feedbackCtl.text,
          'medias': images.map((e) => {'type': 0, 'key': e}).toList()
        },
            (data) => null));

    request(
        api: api,
        success: (_) {
          saveDate();
          EasyLoading.showToast('已提交成功，感谢您的建议');
          Get.back();
        });
  }

/*存储*/
  Future<void> saveDate() async {
    var prefs = await SharedPreferences.getInstance();
    var currentDate = DateTime.now().yyyymmdd;
    prefs.setString("feedbackTime", currentDate);
  }

  /*判断是否已经提价过今天*/
  Future<bool> isSubmited() async {
    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getString("feedbackTime");
    var currentDate = DateTime.now().yyyymmdd;
    return result == currentDate ? true : false;
  }
}