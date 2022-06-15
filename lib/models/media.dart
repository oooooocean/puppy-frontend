import 'package:frontend/services/qiniu_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

enum MediaType {
  @JsonValue(0)
  picture,
  @JsonValue(1)
  video
}

@JsonSerializable()
class Media {
  MediaType type;
  String key;

  Media(this.type, this.key);

  factory Media.fromJson(Map<String, dynamic> json) =>  _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);

  @override
  String toString() => '';

  String get url => QiniuService.shared.fetchImageUrl(key: key);

  String thumbnailUrl({int? width, int? height}) => QiniuService.shared.fetchCustomImageUrl(key: key, width: width, height: height);
}