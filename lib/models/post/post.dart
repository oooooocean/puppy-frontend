import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/models/base.dart';
import 'package:frontend/models/media.dart';
import 'package:frontend/models/pet/pet.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/qiniu_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

enum PostType {
  @JsonValue(0)
  photo,

  @JsonValue(1)
  video
}

@JsonSerializable()
class Post extends OwnerBase {
  int id;
  String description;
  PostType type;
  int praiseCount;
  int commentCount;
  bool hasPraise;
  @JsonKey(fromJson: string2DateTime)
  DateTime createTime;
  List<PetBaseInfo> pets;
  List<Media> medias;

  Post(this.id, this.description, this.type, this.praiseCount, this.commentCount,
      this.createTime, this.pets, this.medias, this.hasPraise, UserInfo ownerInfo, int owner) : super(owner, ownerInfo);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() => '';

  String get avatarUrl => QiniuService.shared.fetchImageUrl(key: ownerInfo.avatar, policy: QiniuPolicy.thumbnail200);
}
