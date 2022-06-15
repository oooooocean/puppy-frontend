import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/models/base.dart';
import 'package:frontend/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_comment.g.dart';

@JsonSerializable()
class PostComment extends OwnerBase {
  int id;
  String description;
  @JsonKey(fromJson: string2DateTime)
  DateTime createTime;

  PostComment(this.id, this.description, this.createTime, UserInfo ownerInfo, int owner) : super(owner, ownerInfo);

  factory PostComment.fromJson(Map<String, dynamic> json) =>  _$PostCommentFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentToJson(this);

  @override
  String toString() => '';
}