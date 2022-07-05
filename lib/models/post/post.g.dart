// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSocial _$PostSocialFromJson(Map<String, dynamic> json) => PostSocial(
      json['praiseCount'] as int,
      json['commentCount'] as int,
      convertBoolToRx(json['hasPraise'] as bool),
      convertBoolToRx(json['hasFollow'] as bool),
    );

Map<String, dynamic> _$PostSocialToJson(PostSocial instance) =>
    <String, dynamic>{
      'praiseCount': instance.praiseCount,
      'commentCount': instance.commentCount,
      'hasPraise': instance.hasPraise,
      'hasFollow': instance.hasFollow,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as int,
      json['description'] as String,
      $enumDecode(_$PostTypeEnumMap, json['type']),
      (json['noticeUsers'] as List<dynamic>)
          .map((e) => BaseUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      PostSocial.fromJson(json['social'] as Map<String, dynamic>),
      string2DateTime(json['createTime'] as String),
      (json['pets'] as List<dynamic>)
          .map((e) => PetBaseInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['medias'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['topics'] as List<dynamic>)
          .map((e) => PostTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
      UserInfo.fromJson(json['ownerInfo'] as Map<String, dynamic>),
      json['owner'] as int,
    )..address = json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'ownerInfo': instance.ownerInfo,
      'owner': instance.owner,
      'id': instance.id,
      'description': instance.description,
      'type': _$PostTypeEnumMap[instance.type],
      'noticeUsers': instance.noticeUsers,
      'social': instance.social,
      'createTime': instance.createTime.toIso8601String(),
      'pets': instance.pets,
      'medias': instance.medias,
      'topics': instance.topics,
      'address': instance.address,
    };

const _$PostTypeEnumMap = {
  PostType.photo: 0,
  PostType.video: 1,
};
