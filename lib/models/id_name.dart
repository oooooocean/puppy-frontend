import 'package:json_annotation/json_annotation.dart';

part 'id_name.g.dart';

@JsonSerializable()
class IdAndName {
  final String id;
  final String name;

  IdAndName(this.id, this.name);

  factory IdAndName.fromJson(Map<String, dynamic> json) =>  _$IdAndNameFromJson(json);
  Map<String, dynamic> toJson() => _$IdAndNameToJson(this);

  @override
  String toString() => '';
}