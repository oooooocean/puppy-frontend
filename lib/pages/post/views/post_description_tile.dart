import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:frontend/models/user/user.dart';
import 'package:more/iterable.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostDescriptionTile extends StatefulWidget {
  final String description;
  final List<PostTopic> topics;
  final List<BaseUser> notices;
  final ValueSetter<PostTopic> onTap;
  final ValueSetter<BaseUser> onNotice;

  const PostDescriptionTile(
      {Key? key,
      required this.description,
      required this.topics,
      required this.notices,
      required this.onTap,
      required this.onNotice})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescriptionTile> {
  late List<TapGestureRecognizer> gestures;
  late List<TapGestureRecognizer> noticeGestures;

  @override
  void initState() {
    gestures = widget.topics.map((e) => TapGestureRecognizer()..onTap = () => widget.onTap(e)).toList();
    noticeGestures = widget.notices.map((e) => TapGestureRecognizer()..onTap = () => widget.onNotice(e)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topics = [widget.topics, gestures]
        .zip()
        .map((e) => TextSpan(
            text: '#${(e[0] as PostTopic).title} ',
            recognizer: e[1] as TapGestureRecognizer,
            style: const TextStyle(color: kBlueColor, fontSize: kSmallFont)))
        .toList();
    final notices = [widget.notices, noticeGestures]
        .zip()
        .map((e) => TextSpan(
            text: '@${(e[0] as BaseUser).info!.nickname} ',
            recognizer: e[1] as TapGestureRecognizer,
            style: const TextStyle(color: kBlueColor, fontSize: kSmallFont)))
        .toList();
    return Text.rich(TextSpan(text: widget.description, children: notices + topics),
        maxLines: 7,
        style: TextStyle(color: kPrimaryTextColor, fontSize: 15.toPadding, overflow: TextOverflow.ellipsis));
  }

  @override
  void dispose() {
    gestures.forEach((element) => element.dispose());
    super.dispose();
  }
}
