// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      json['id'] as int,
      json['owner'] as int,
      UserInfo.fromJson(json['ownerInfo'] as Map<String, dynamic>),
      json['nickname'] as String,
      json['avatar'] as String,
      json['introduction'] as String,
      PetIntrinsic.fromJson(json['intrinsic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'ownerInfo': instance.ownerInfo,
      'owner': instance.owner,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'introduction': instance.introduction,
      'intrinsic': instance.intrinsic,
    };

PetIntrinsic _$PetIntrinsicFromJson(Map<String, dynamic> json) => PetIntrinsic(
      $enumDecode(_$GenderEnumMap, json['gender']),
      json['category'] as int,
      json['subCategory'] as int,
      string2DateTime(json['birthday'] as String),
      json['neuter'] as bool?,
    );

Map<String, dynamic> _$PetIntrinsicToJson(PetIntrinsic instance) =>
    <String, dynamic>{
      'gender': _$GenderEnumMap[instance.gender],
      'category': instance.category,
      'subCategory': instance.subCategory,
      'birthday': instance.birthday.toIso8601String(),
      'neuter': instance.neuter,
    };

const _$GenderEnumMap = {
  Gender.male: 0,
  Gender.female: 1,
};
