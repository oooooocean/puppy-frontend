// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdAndName _$IdAndNameFromJson(Map<String, dynamic> json) => IdAndName(
      int2String(json['id']),
      json['name'] as String,
    );

Map<String, dynamic> _$IdAndNameToJson(IdAndName instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
