// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUser _$BaseUserFromJson(Map<String, dynamic> json) => BaseUser(
      json['id'] as int,
      UserInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseUserToJson(BaseUser instance) => <String, dynamic>{
      'id': instance.id,
      'info': instance.info,
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
      json['id'] as int,
      json['info'] == null
          ? null
          : UserInfo.fromJson(json['info'] as Map<String, dynamic>),
      json['petCount'] as int,
      json['hasPassword'] as bool,
    );

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
      'id': instance.id,
      'info': instance.info,
      'petCount': instance.petCount,
      'hasPassword': instance.hasPassword,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      UserInfo.fromJson(json['info'] as Map<String, dynamic>),
      UserSocialInfo.fromJson(json['social'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'info': instance.info,
      'social': instance.social,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['nickname'] as String,
      $enumDecode(_$GenderEnumMap, json['gender']),
      json['avatar'] as String,
      json['introduction'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'gender': _$GenderEnumMap[instance.gender],
      'avatar': instance.avatar,
      'introduction': instance.introduction,
    };

const _$GenderEnumMap = {
  Gender.male: 0,
  Gender.female: 1,
};

UserSocialInfo _$UserSocialInfoFromJson(Map<String, dynamic> json) =>
    UserSocialInfo(
      json['praiseCount'] as int,
      json['fansCount'] as int,
      json['idolCount'] as int,
      convertBoolToRx(json['hasFollow'] as bool),
    );

Map<String, dynamic> _$UserSocialInfoToJson(UserSocialInfo instance) =>
    <String, dynamic>{
      'praiseCount': instance.praiseCount,
      'fansCount': instance.fansCount,
      'idolCount': instance.idolCount,
      'hasFollow': instance.hasFollow,
    };
