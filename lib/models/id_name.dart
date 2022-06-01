import 'package:json_annotation/json_annotation.dart';

part 'id_name.g.dart';

int2String(dynamic input) => input.toString();

@JsonSerializable()
class IdAndName {
  @JsonKey(fromJson: int2String)
  final String id;
  final String name;

  IdAndName(this.id, this.name);

  factory IdAndName.fromJson(Map<String, dynamic> json) =>  _$IdAndNameFromJson(json);
  Map<String, dynamic> toJson() => _$IdAndNameToJson(this);

  @override
  String toString() => '';
}