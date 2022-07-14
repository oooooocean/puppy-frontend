import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/models/id_name.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/qiniu_service.dart';
import 'package:get/get.dart';
import 'package:frontend/models/net_response.dart';
import 'package:frontend/net/net.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:more/src/tuple/tuple_2.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:more/iterable.dart';
import 'package:frontend/models/media.dart';

mixin NetMixin {
  final net = Net();

  bool get shouldRequest => true;

  Future? request<T>({required ValueGetter<Future<T>> api, ValueSetter<T>? success, ValueSetter<Error>? fail}) async {
    if (!shouldRequest) {
      EasyLoading.showToast('请完善信息后重试');
      return;
    }

    EasyLoading.show();
    return api().then((value) {
      EasyLoading.dismiss();
      if (success != null) success(value);
    }).catchError((error) {
      EasyLoading.dismiss();
      EasyLoading.showToast(error.toString());
      if (fail != null) fail(error);
      if (!const bool.fromEnvironment("dart.vm.product")) throw error;
    });
  }

  Future<T> get<T>(String uri, Decoder<T> decoder, {Map<String, dynamic>? query}) async {
    final res = (await net.get<NetResponse>(uri, query: query, decoder: net.defaultDecoder)).body;
    return _parse(res, decoder);
  }

  Future<T> post<T>(String uri, Map<String, dynamic> body, Decoder<T> decoder) async {
    print(body);
    final res =
        (await net.post<NetResponse>(uri, body, contentType: 'application/json', decoder: net.defaultDecoder)).body;
    return _parse(res, decoder);
  }

  Future<T> patch<T>(String uri, Map<String, dynamic> body, Decoder<T> decoder) async {
    final res =
        (await net.patch<NetResponse>(uri, body, contentType: 'application/json', decoder: net.defaultDecoder)).body;
    return _parse(res, decoder);
  }

  Future<T> delete<T>(String uri, Map<String, dynamic>? query, Decoder<T> decoder) async {
    final res = (await net.delete<NetResponse>(uri, query: query, decoder: net.defaultDecoder)).body;
    return _parse(res, decoder);
  }

  /// 上传图片
  /// 默认会对图片按照当前屏幕进行压缩
  Future<List<Media>> uploadImages(List<AssetEntity> files, {bool originSize = false}) async {
    final types = files.map((e) => e.type.mediaType).toList();
    final filesFutures = files
        .map(
          (entity) => originSize
              ? entity.originBytes
              : entity.thumbnailDataWithSize(
                  ThumbnailSize(min(Get.width * Get.pixelRatio, entity.size.width).toInt(),
                      min(Get.height * Get.pixelRatio, entity.size.height).toInt()),
                  quality: 50,
                  format: ThumbnailFormat.jpeg),
        )
        .toList();
    // 获取有效压缩后的文件
    final validFilesFuture =
        Future.wait(filesFutures).then((files) => files.where((element) => element != null).map((e) => e!).toList());

    return validFilesFuture.then((files) {
      if (files.isEmpty) return [];
      // 上传到文件服务器
      return _getUploadTokens(files.length).then((metas) {
        final uploadFutures = [metas, files, types].zip().map((e) {
          final meta = e[0] as IdAndName;
          final key = QiniuService.shared.upload(key: meta.id, token: meta.name, bytes: e[1] as Uint8List);
          return key.then((value) => Media(e[2] as MediaType, value));
        }).toList();
        return Future.wait(uploadFutures);
      });
    });
  }

  /// 从服务端获取上传文件的Token
  Future<List<IdAndName>> _getUploadTokens(int count) => get('upload_token/', query: {'count': count.toString()},
      (data) => (data as List<dynamic>).map((e) => IdAndName.fromJson(e)).toList());

  Future<T> _parse<T>(NetResponse? res, Decoder<T> decoder) async {
    if (res == null) throw NetError()..message = '服务端返回无法解析';
    if (res.code != NetCode.success) {
      if (res.code == NetCode.loginOverdue) {
        Get.find<LaunchService>().restart();
      }
      throw res;
    }
    return decoder(res.data);
  }
}
