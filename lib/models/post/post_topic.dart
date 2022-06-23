import 'package:json_annotation/json_annotation.dart';

part 'post_topic.g.dart';

@JsonSerializable()
class PostTopic {
  int id;
  String title;
  int contentCount;

  PostTopic(this.id, this.title, this.contentCount);

  factory PostTopic.fromJson(Map<String, dynamic> json) =>  _$PostTopicFromJson(json);

  @override
  String toString() => '';
}