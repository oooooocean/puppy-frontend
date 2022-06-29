import 'dart:convert';
import 'package:frontend/services/qiniu_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/services/store.dart';
import '../gender.dart';

part 'user.g.dart';

@JsonSerializable()
class BaseUser {
  int id;
  UserInfo? info;

  BaseUser(this.id, this.info);

  factory BaseUser.fromJson(Map<String, dynamic> json) =>  _$BaseUserFromJson(json);
  Map<String, dynamic> toJson() => _$BaseUserToJson(this);

  @override
  String toString() => '';
}

@JsonSerializable()
class User extends BaseUser with LoadImageMixin {
  int petCount;
  UserSocialInfo social;

  User(int id, UserInfo? info, this.petCount, this.social) : super(id, info);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User: $id';

  void save() => Store.set('user', const JsonEncoder().convert(toJson()));

  static Future<User?> cached() =>
      Store.get('user', decoder: (data) => User.fromJson(const JsonDecoder().convert(data)));
}

@JsonSerializable()
class UserInfo {
  String nickname;
  Gender gender;
  String avatar;
  String introduction;

  UserInfo(this.nickname, this.gender, this.avatar, this.introduction);

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  String toString() => '';

  String get avatarUrl => QiniuService.shared.fetchImageUrl(key: avatar, policy: QiniuPolicy.thumbnail200);
}

@JsonSerializable()
class UserSocialInfo {
  final int praiseCount;
  final int fansCount;
  final int idolCount;

  UserSocialInfo(this.praiseCount, this.fansCount, this.idolCount);

  factory UserSocialInfo.fromJson(Map<String, dynamic> json) =>  _$UserSocialInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserSocialInfoToJson(this);

  @override
  String toString() => '';
}
