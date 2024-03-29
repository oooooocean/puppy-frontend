import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue(0)
  male,
  @JsonValue(1)
  female
}

extension GenderExtension on Gender {
  String get string => ['男', '女'][index];

  IconData get humanIcon => this == Gender.male ? Icons.male : Icons.female;
}
