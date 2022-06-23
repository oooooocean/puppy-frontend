import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart' show BMFMapSDK, BMF_COORD_TYPE;

class BDMapService {
  static final shared = BDMapService();
  var _hasInit = false;

  /// 初始化配置
  Future<bool> initIfNeed() async {
    final hasPermission = await requestLocationPermission();
    if (!hasPermission) return false;
    if (_hasInit) return true;
    _hasInit = true;

    final bd = LocationFlutterPlugin();
    bd.setAgreePrivacy(true);
    BMFMapSDK.setAgreePrivacy(true);
    if (Platform.isIOS) {
      bd.authAK('AKFemw1tLs7GyX3Cu10693tAXpN9bAkr');
      BMFMapSDK.setApiKeyAndCoordType('AKFemw1tLs7GyX3Cu10693tAXpN9bAkr', BMF_COORD_TYPE.BD09LL);
    }
    bd.getApiKeyCallback(callback: (String result) => print('百度地图鉴权结果: $result'));
    return true;
  }

  /// 检查定位权限
  /// 尝试请求一次定位权限
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    switch (status) {
      case PermissionStatus.granted:
        return true;
      default:
        status = await Permission.location.request();
        return status == PermissionStatus.granted;
    }
  }

  /// 定位
  BaiduLocationIOSOption initIOSOptions() {
    BaiduLocationIOSOption options = BaiduLocationIOSOption(
        coordType: BMFLocationCoordType.bd09ll,
        BMKLocationCoordinateType: 'BMKLocationCoordinateTypeBMK09LL',
        desiredAccuracy: BMFDesiredAccuracy.best);
    return options;
  }

  BaiduLocationAndroidOption initAndroidOptions() {
    BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
        coorType: 'bd09ll',
        locationMode: BMFLocationMode.hightAccuracy,
        isNeedAddress: true,
        isNeedAltitude: true,
        isNeedLocationPoiList: true,
        isNeedNewVersionRgc: true,
        isNeedLocationDescribe: true,
        openGps: true,
        locationPurpose: BMFLocationPurpose.sport,
        coordType: BMFLocationCoordType.bd09ll);
    return options;
  }

  startLocation(LocationFlutterPlugin plugin, ValueSetter<BaiduLocation> callback) async {
    if (Platform.isIOS) {
      plugin.singleLocationCallback(callback: callback);
      await plugin.prepareLoc(initAndroidOptions().getMap(), initIOSOptions().getMap());
      await plugin.singleLocation({'isReGeocode': true, 'isNetworkState': true});
    } else {
      plugin.seriesLocationCallback(callback: (BaiduLocation result) {
        plugin.stopLocation();
        callback(result);
      });
      await plugin.startLocation();
    }
  }
}
