import 'package:frontend/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import '../gender.dart';
import 'package:frontend/components/extension/date_extension.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet {
  final int id;
  final UserInfo ownerInfo;
  final int owner;
  final String nickname;
  final String avatar;
  final String introduction;
  final PetIntrinsic intrinsic;

  Pet(this.id, this.owner, this.ownerInfo, this.nickname, this.avatar, this.introduction, this.intrinsic);

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);

  @override
  String toString() => '';
}

/// 宠物的自然属性
@JsonSerializable()
class PetIntrinsic {
  final Gender gender;
  final int category;
  final int subCategory;
  @JsonKey(fromJson: string2DateTime)
  final DateTime birthday;

  /// 是否绝育
  final bool? neuter;

  PetIntrinsic(this.gender, this.category, this.subCategory, this.birthday, this.neuter);

  factory PetIntrinsic.fromJson(Map<String, dynamic> json) => _$PetIntrinsicFromJson(json);

  Map<String, dynamic> toJson() => _$PetIntrinsicToJson(this);

  @override
  String toString() => '';
}
