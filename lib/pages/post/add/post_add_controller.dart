import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/bdmap_service.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostAddController extends GetxController with NetMixin {
  var assets = RxList<AssetEntity>();
  var descriptionCtl = TextEditingController();
  var isOpen = true.obs;
  PostTopic? topic;

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

  onTapTopic() async {
    final selected = await Get.toNamed(AppRoutes.postTopicList) as PostTopic?;
    if (selected == null) return;
    topic = selected;
    update(['topic']);
  }

  onTapFocus() {}

  onTapMap() async {
    bool isSuccess = await BDMapService.shared.initIfNeed();
    if (!isSuccess) return;

    final selected = await Get.toNamed(AppRoutes.postLocation) as Tuple2<BaiduLocation, BaiduPoiList?>?;
    if (selected == null) return;
    print(selected);
  }

  onTapPhoto() {}

  onTapViewStyle() => isOpen.value = !isOpen.value;
}
