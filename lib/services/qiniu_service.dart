import 'dart:typed_data';

import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

class QiniuService {
  static final shared = QiniuService();

  Future<String> upload({required String key, required String token, required Uint8List bytes}) {
    return Storage().putBytes(bytes, token, options: PutOptions(key: key)).then((value) => value.key!);
  }
}
