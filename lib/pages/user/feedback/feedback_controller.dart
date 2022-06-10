
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
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

  /// 选择的问题类型
  List<String> itmeDescs = ['功能问题：功能故障','体验问题：我有建议','安全问题：密码、隐私','其他问题'];

  List<AssetEntity> covers = [];

  ///最大图片数量
  var maxAssets = 2;

  @override
  onReady(){

    isSubmited().then((value) => {
      if(value == true) {
        EasyLoading.showToast("今天您已经提过建议啦，请明天再提")
      }
    }).then((value) => {
      isLimit.value = true
    });
  }

  bool get shouldNext => feedbackCtl.text.isNotEmpty && selectIndex > -1 && !isLimit.value;
  void choseCover() async {
    final config = AssetPickerConfig(
        selectedAssets: covers.length == maxAssets ? covers : null, maxAssets: maxAssets-covers.length, requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    covers.isEmpty && results.length == maxAssets ? covers = results : covers.add(results.first);
    update(['cover']);
  }

  void selectCell (int index) {
    selectIndex = index;
    update(['listView','next']);
  }

  /// 意见反馈请求
  feedback() {
    isSubmited().then((value) => {
      if(value == true) {
        EasyLoading.showToast("今天您已经提过建议啦，请明天再提")
      }else {
        requestMethod()
      }
    });

  }

  void requestMethod () {
    Future<Map<String, dynamic>>? params;

    if (covers.isNotEmpty){
      params = uploadImages(covers)
          .then((value) =>  dealWithImageData(value))
          .then((images) => {
        'title':itmeDescs[selectIndex],
        'description':feedbackCtl.text,
        'medias':images

      });
    }else {

      params = Future(() => {
        'title': itmeDescs[selectIndex],
        'description': feedbackCtl.text,
        'medias': []
      });

    }
    Future?  api = params.then((value) => post('feedback/', value, (data) => null));

    request(
        api: api,
        success: (data) {
          saveDate();
          EasyLoading.showToast('已提交成功，感谢您的建议');
          Get.back();
        });
  }
  /// 处理下拼接图片信息
  Future<List> dealWithImageData(List<String> results) async {
    List medias =[];
    if(results.isNotEmpty) {
      for (var element in results) {
        Map map =  {'type':0,'key':element };
        medias.add(map);
      }
    }
    return medias;
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
    return result == currentDate ? true : false ;
  }


}