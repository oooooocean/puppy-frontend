
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class FeedbackController extends GetxController with NetMixin {

  final feedbackCtl = TextEditingController();

  /// 选择的理由
  var selectIndex = -1.obs;

  /// 是否可以发送
  var feedbackEnable = false.obs;

  /// 是否限制，默认一天只能发送一次
  var isLimit = false.obs;

   List<String> itmeDescs = ['功能问题：功能故障','体验问题：我有建议','安全问题：密码、隐私','其他问题'];

  AssetEntity? cover;

  bool get shouldNext => feedbackCtl.text.isNotEmpty && selectIndex > 0 ;
  void choseCover() async {
    final config = AssetPickerConfig(
        selectedAssets: cover != null ? [cover!] : null, maxAssets: 2, requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    cover = results.first;
    update(['cover']);
  }
  void selectCell (int index) {

    selectIndex = index;
    update(['listView']);

  }

  feedback() {
    List<AssetEntity> image = cover != null ? [cover!] : [];



  }
/*存储*/
  saveDate() async {
    var prefs = await SharedPreferences.getInstance();
    var currentDate = DateTime.now().yyyymmdd;
    prefs.setString("feedbackTime", currentDate);
  }

  Future<bool> isSubmited() async {

    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getString("feedbackTime");
    var currentDate = DateTime.now().yyyymmdd;
    return result == currentDate ? true : false ;

  }


}