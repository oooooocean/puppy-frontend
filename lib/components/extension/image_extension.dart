import 'package:frontend/services/qiniu_service.dart';

extension String2Image on String {
  String get toImageUrl => QiniuService.shared.fetchImageUrl(key: this);
  String get to200PxImageUrl => QiniuService.shared.fetchImageUrl(key: this, policy: QiniuPolicy.thumbnail200);
}