// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTopic _$PostTopicFromJson(Map<String, dynamic> json) => PostTopic(
      json['id'] as int,
      json['title'] as String,
      json['contentCount'] as int,
    );

Map<String, dynamic> _$PostTopicToJson(PostTopic instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contentCount': instance.contentCount,
    };
