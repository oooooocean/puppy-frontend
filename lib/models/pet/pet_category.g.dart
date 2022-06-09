// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetCategory _$PetCategoryFromJson(Map<String, dynamic> json) => PetCategory(
      int2String(json['id']),
      json['name'] as String,
      (json['subCategory'] as List<dynamic>)
          .map((e) => PetSubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['hotCategory'] as List<dynamic>).map((e) => e as int).toList(),
    );

PetSubCategory _$PetSubCategoryFromJson(Map<String, dynamic> json) =>
    PetSubCategory(
      int2String(json['id']),
      json['name'] as String,
      json['image'] as String,
    );
