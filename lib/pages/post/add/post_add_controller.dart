import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostAddController extends GetxController with NetMixin {
  var photos = RxList<AssetEntity>().obs;

  onPublish() {}
}