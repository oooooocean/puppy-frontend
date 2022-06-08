import 'package:frontend/models/id_name.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet_category.g.dart';

class PetExplicitCategory {
  final PetCategory category;
  final PetSubCategory subCategory;

  PetExplicitCategory(this.category, this.subCategory);

  bool get isValid => category.subCategory.contains(subCategory);
}

@JsonSerializable()
class PetCategory extends IdAndName {
  List<PetSubCategory> subCategory;
  List<int> hotCategory;

  PetCategory(String id, String name, this.subCategory, this.hotCategory)
      : super(id, name);

  factory PetCategory.fromJson(Map<String, dynamic> json) =>
      _$PetCategoryFromJson(json);

  @override
  String toString() => '';
}

@JsonSerializable()
class PetSubCategory extends IdAndName {
  String image;

  PetSubCategory(String id, String name, this.image) : super(id, name);

  factory PetSubCategory.fromJson(Map<String, dynamic> json) =>
      _$PetSubCategoryFromJson(json);

  @override
  String toString() => '';
}
