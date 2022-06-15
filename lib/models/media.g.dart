// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      $enumDecode(_$MediaTypeEnumMap, json['type']),
      json['key'] as String,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'type': _$MediaTypeEnumMap[instance.type],
      'key': instance.key,
    };

const _$MediaTypeEnumMap = {
  MediaType.picture: 0,
  MediaType.video: 1,
};
