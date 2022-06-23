// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as int,
      json['description'] as String,
      $enumDecode(_$PostTypeEnumMap, json['type']),
      json['praiseCount'] as int,
      json['commentCount'] as int,
      string2DateTime(json['createTime'] as String),
      (json['pets'] as List<dynamic>)
          .map((e) => PetBaseInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['medias'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      convertBoolToRx(json['hasPraise'] as bool),
      convertBoolToRx(json['hasFollow'] as bool),
      (json['topics'] as List<dynamic>)
          .map((e) => PostTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
      UserInfo.fromJson(json['ownerInfo'] as Map<String, dynamic>),
      json['owner'] as int,
    );


const _$PostTypeEnumMap = {
  PostType.photo: 0,
  PostType.video: 1,
};
