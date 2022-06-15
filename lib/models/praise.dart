import 'package:frontend/components/extension/date_extension.dart';
import 'package:frontend/models/base.dart';
import 'package:frontend/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'praise.g.dart';

@JsonSerializable()
class Praise extends OwnerBase {
  int id;
  @JsonKey(fromJson: string2DateTime)
  DateTime createTime;

  Praise(this.id, UserInfo ownerInfo, int owner, this.createTime) : super(owner, ownerInfo);

  factory Praise.fromJson(Map<String, dynamic> json) =>  _$PraiseFromJson(json);
  Map<String, dynamic> toJson() => _$PraiseToJson(this);

  @override
  String toString() => '';
}