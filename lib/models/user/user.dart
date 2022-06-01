import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/services/store.dart';
import '../gender.dart';

part 'user.g.dart';

@JsonSerializable()
class User with LoadImageMixin {
  String phone;
  int id;
  int petCount;
  UserInfo? info;

  User(this.id, this.phone, this.info, this.petCount);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User: $phone';

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
}
