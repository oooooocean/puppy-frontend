// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['phone'] as String,
      json['info'] == null
          ? null
          : UserInfo.fromJson(json['info'] as Map<String, dynamic>),
      json['petCount'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phone': instance.phone,
      'id': instance.id,
      'petCount': instance.petCount,
      'info': instance.info,
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
