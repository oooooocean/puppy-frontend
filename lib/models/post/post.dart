import 'package:frontend/components/extension/date_extension.dart';
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
class Post extends OwnerBase {
  int id;
  String description;
  PostType type;
  int praiseCount;
  int commentCount;

  /// 是否点赞
  @JsonKey(fromJson: convertBoolToRx)
  RxBool hasPraise;

  /// 是否关注
  @JsonKey(fromJson: convertBoolToRx)
  RxBool hasFollow;
  @JsonKey(fromJson: string2DateTime)
  DateTime createTime;
  List<PetBaseInfo> pets;
  List<Media> medias;
  List<PostTopic> topics;

  Post(this.id, this.description, this.type, this.praiseCount, this.commentCount, this.createTime, this.pets,
      this.medias, this.hasPraise, this.hasFollow, this.topics, UserInfo ownerInfo, int owner)
      : super(owner, ownerInfo);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  String toString() => '帖子: $id';

  bool get isCurrentUser => LaunchService.shared.user?.id == owner;
}
