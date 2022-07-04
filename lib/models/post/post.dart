import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/models/address.dart';
import 'package:frontend/models/base.dart';
import 'package:frontend/models/media.dart';
import 'package:frontend/models/pet/pet.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/services/launch_service.dart';
import 'package:frontend/services/utils.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

enum PostType {
  @JsonValue(0)
  photo,

  @JsonValue(1)
  video
}

@JsonSerializable()
class PostSocial {
  int praiseCount;
  int commentCount;
  /// 是否点赞
  @JsonKey(fromJson: convertBoolToRx)
  RxBool hasPraise;

  /// 是否关注
  @JsonKey(fromJson: convertBoolToRx)
  RxBool hasFollow;

  PostSocial(this.praiseCount, this.commentCount, this.hasPraise, this.hasFollow);

  factory PostSocial.fromJson(Map<String, dynamic> json) =>  _$PostSocialFromJson(json);
  Map<String, dynamic> toJson() => _$PostSocialToJson(this);

  @override
  String toString() => '';
}

@JsonSerializable()
class Post extends OwnerBase {
  int id;
  String description;
  PostType type;

  /// @列表
  List<BaseUser> noticeUsers;

  PostSocial social;
  @JsonKey(fromJson: string2DateTime)
  DateTime createTime;
  List<PetBaseInfo> pets;
  List<Media> medias;
  List<PostTopic> topics;
  Address? address;

  Post(this.id, this.description, this.type, this.noticeUsers, this.social, this.createTime, this.pets,
      this.medias, this.topics, UserInfo ownerInfo, int owner)
      : super(owner, ownerInfo);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  String toString() => '帖子: $id';

  bool get isCurrentUser => LaunchService.shared.user?.id == owner;
}
