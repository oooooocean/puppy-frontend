import 'dart:typed_data';

import 'package:frontend/services/app_configuration.dart';
import 'package:get/get.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

enum QiniuPolicy {
  simple,
  thumbnail200;

  String get key {
    switch (this) {
      case QiniuPolicy.simple:
        return '?imageslim';
      case QiniuPolicy.thumbnail200:
        return '-thumbnail200x200.AspectFill';
    }
  }
}

enum QiniuBucket {
  resource,
  develop,
  product;

  String get host {
    switch (this) {
      case QiniuBucket.resource:
        return 'http://qiniu.sesame.fun/';
      case QiniuBucket.develop:
        return 'http://qiniudevelop.sesame.fun/';
      case QiniuBucket.product:
        return 'http://qiniuproduct.sesame.fun/';
    }
  }
}

class QiniuService {
  static final shared = QiniuService();

  Future<String> upload({required String key, required String token, required Uint8List bytes}) {
    return Storage().putBytes(bytes, token, options: PutOptions(key: key)).then((value) => value.key!);
  }

  String fetchImageUrl({required String key, bool isResource = false, QiniuPolicy policy = QiniuPolicy.simple}) {
    final bucket = _fetchBucket(isResource);
    return bucket.host + key + policy.key;
  }

  String fetchCustomImageUrl({required String key, bool isResource = false, int? width, int? height}) {
    assert(width != null || height != null, '请使用fetchImageUrl');
    String policy;
    int ratio = Get.pixelRatio.toInt();
    if (width == null) {
      policy = 'h/${height! * ratio}';
    } else if (height == null) {
      policy = 'w/${width * ratio}';
    } else {
      policy = 'w/${width * ratio}/h/${height * ratio}';
    }
    final bucket = _fetchBucket(isResource);
    return '${bucket.host}$key?imageView2/0/$policy/ignore-error/1';
  }

  QiniuBucket _fetchBucket(bool isResource) => isResource
      ? QiniuBucket.resource
      : (currentEnvironment == Environment.product ? QiniuBucket.product : QiniuBucket.develop);
}
