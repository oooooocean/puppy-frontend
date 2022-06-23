import 'package:flutter/cupertino.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:frontend/services/bdmap_service.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostLocationController extends GetxController {
  final refreshController = RefreshController(initialRefresh: true);
  final searchCtl = TextEditingController();
  var searchResult = RxList<BaiduPoiList>();
  final _locationPlugin = LocationFlutterPlugin();
  final List<BaiduPoiList> _rawPois = [];
  BaiduLocation? _location;

  onSearch(String keyword) {}

  onLoading() {
    BDMapService.shared.startLocation(_locationPlugin, (value) {
      _location = value;
      _rawPois.clear();
      _rawPois.add(BaiduPoiList(name: '不显示位置'));
      _rawPois.add(BaiduPoiList(name: value.city));
      _rawPois.addAll(value.pois ?? []);
      searchResult.value = _rawPois;
      refreshController.refreshCompleted();
      update(['location']);
    });
  }

  onTap(int index) {
    switch (index) {
      case 0:
        Get.back();
        break;
      case 1:
        Get.back(result: Tuple2(_location!, null));
        break;
      default:
        Get.back(result: Tuple2(_location!, searchResult[index]));
        break;
    }
  }
}
