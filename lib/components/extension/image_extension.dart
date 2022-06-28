import 'package:frontend/services/qiniu_service.dart';

extension String2Image on String {
  String get toImageUrl => QiniuService.shared.fetchImageUrl(key: this);
  String get to200PxImageUrl => QiniuService.shared
      .fetchImageUrl(key: this, policy: QiniuPolicy.thumbnail200);

  String get toImageResourceUrl =>
      QiniuService.shared.fetchImageUrl(key: this, isResource: true);
  String get to200PxImageResourceUrl => QiniuService.shared.fetchImageUrl(
      key: this, policy: QiniuPolicy.thumbnail200, isResource: true);
}
