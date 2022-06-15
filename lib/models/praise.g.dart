// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'praise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Praise _$PraiseFromJson(Map<String, dynamic> json) => Praise(
      json['id'] as int,
      UserInfo.fromJson(json['ownerInfo'] as Map<String, dynamic>),
      json['owner'] as int,
      string2DateTime(json['createTime'] as String),
    );

Map<String, dynamic> _$PraiseToJson(Praise instance) => <String, dynamic>{
      'ownerInfo': instance.ownerInfo,
      'owner': instance.owner,
      'id': instance.id,
      'createTime': instance.createTime.toIso8601String(),
    };
