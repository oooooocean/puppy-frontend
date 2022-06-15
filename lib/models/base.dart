import 'package:frontend/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class OwnerBase {
  UserInfo ownerInfo;
  int owner;

  OwnerBase(this.owner, this.ownerInfo);

  @override
  String toString() => '';
}