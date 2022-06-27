import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:frontend/models/media.dart';
import 'package:frontend/models/post/post.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/models/user/user.dart';
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
  Tuple2<BaiduLocation, BaiduPoiList?>? address;
  PostTopic? topic;
  var idols = RxList<BaseUser>();

  @override
  bool get shouldRequest => assets.isNotEmpty && descriptionCtl.text.isNotEmpty;

  onPublish() {
    request(
        api: () => uploadImages(assets).then(
              (medias) => post('post/', _buildPublishParams(medias), (data) => Post.fromJson(data)),
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

  onTapIdols() async {
    final idol = await Get.toNamed(AppRoutes.choseIdol) as BaseUser?;
    if (idol == null || idols.map((element) => element.id).toSet().contains(idol.id)) return;
    idols.add(idol);
  }

  onTapMap() async {
    bool isSuccess = await BDMapService.shared.initIfNeed();
    if (!isSuccess) return;

    final selected = await Get.toNamed(AppRoutes.postLocation) as Tuple2<BaiduLocation, BaiduPoiList?>?;
    if (selected == null) return;
    address = selected;
    update(['address']);
  }

  onTapPhoto() {}

  onTapViewStyle() => isOpen.value = !isOpen.value;

  Map<String, dynamic> _buildPublishParams(List<Media> medias) {
    var params = {'type': 0, 'description': descriptionCtl.text, 'medias': medias.map((e) => e.toJson()).toList()};
    final address = this.address;
    if (address != null) {
      final base = address.first;
      params['address'] = {
        'town': base.town,
        'latitude': base.latitude,
        'longitude': base.longitude,
        'country': base.country,
        'province': base.province,
        'city': base.city,
        'district': base.district,
        'street': base.street,
        'ad_code': base.adCode,
        'city_code': base.cityCode,
        'address': base.address,
        'slang': base.locationDetail,
        'poi_name': address.second?.name,
        'poi_address': address.second?.addr,
      };
    }
    if (topic != null) {
      params['topics'] = [topic!.id];
    }
    if (idols.isNotEmpty) {
      params['notice_users'] = idols.map((element) => element.id).toList();
    }
    return params;
  }
}
