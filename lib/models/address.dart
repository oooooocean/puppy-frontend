import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  double longitude;
  double latitude;
  String country;
  String province;
  String city;
  String? poiName;

  Address(this.longitude, this.latitude, this.country, this.province, this.city, this.poiName);

  factory Address.fromJson(Map<String, dynamic> json) =>  _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() => '';
}