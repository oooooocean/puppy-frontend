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
      json['hasPraise'] as bool,
      UserInfo.fromJson(json['ownerInfo'] as Map<String, dynamic>),
      json['owner'] as int,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'ownerInfo': instance.ownerInfo,
      'owner': instance.owner,
      'id': instance.id,
      'description': instance.description,
      'type': _$PostTypeEnumMap[instance.type],
      'praiseCount': instance.praiseCount,
      'commentCount': instance.commentCount,
      'hasPraise': instance.hasPraise,
      'createTime': instance.createTime.toIso8601String(),
      'pets': instance.pets,
      'medias': instance.medias,
    };

const _$PostTypeEnumMap = {
  PostType.photo: 0,
  PostType.video: 1,
};
