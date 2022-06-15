// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostComment _$PostCommentFromJson(Map<String, dynamic> json) => PostComment(
      json['id'] as int,
      json['description'] as String,
      string2DateTime(json['createTime'] as String),
      UserInfo.fromJson(json['ownerInfo'] as Map<String, dynamic>),
      json['owner'] as int,
    );

Map<String, dynamic> _$PostCommentToJson(PostComment instance) =>
    <String, dynamic>{
      'ownerInfo': instance.ownerInfo,
      'owner': instance.owner,
      'id': instance.id,
      'description': instance.description,
      'createTime': instance.createTime.toIso8601String(),
    };
