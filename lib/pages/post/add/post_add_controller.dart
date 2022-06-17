import 'package:flutter/cupertino.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostAddController extends GetxController with NetMixin {
  var assets = RxList<AssetEntity>();
  var descriptionCtl = TextEditingController();
  var isOpen = true.obs;

  @override
  bool get shouldRequest => assets.isNotEmpty && descriptionCtl.text.isNotEmpty;

  onPublish() {
    request(
        api: () => uploadImages(assets).then(
              (medias) => post(
                  'post/',
                  {'type': 0, 'description': descriptionCtl.text, 'medias': medias.map((e) => e.toJson()).toList()},
                  (data) => Post.fromJson(data)),
            ),
        success: (post) {
          print(post);
        },
        fail: (error) {
          print(error);
        });
  }

  onTapPet() {}

  onTapTopic() {}

  onTapFocus() {}

  onTapMap() {}

  onTapPhoto() {}

  onTapViewStyle() => isOpen.value = !isOpen.value;
}
