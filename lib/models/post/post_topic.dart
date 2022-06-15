import 'package:json_annotation/json_annotation.dart';

part 'post_topic.g.dart';

@JsonSerializable()
class PostTopic {
  int id;
  String title;

  PostTopic(this.id, this.title);

  factory PostTopic.fromJson(Map<String, dynamic> json) =>  _$PostTopicFromJson(json);
  Map<String, dynamic> toJson() => _$PostTopicToJson(this);

  @override
  String toString() => '';
}