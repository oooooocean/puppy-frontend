// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      (json['longitude'] as num).toDouble(),
      (json['latitude'] as num).toDouble(),
      json['country'] as String,
      json['province'] as String,
      json['city'] as String,
      json['poiName'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'poiName': instance.poiName,
    };
