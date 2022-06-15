import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/models/post/post_topic.dart';
import 'package:more/iterable.dart';
import 'package:frontend/components/extension/int_extension.dart';

class PostDescriptionTile extends StatefulWidget {
  final String description;
  final List<PostTopic> topics;
  final ValueSetter<PostTopic> onTap;

  const PostDescriptionTile({Key? key, required this.description, required this.topics, required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescriptionTile> {
  late List<TapGestureRecognizer> gestures;

  @override
  void initState() {
    gestures = widget.topics.map((e) => TapGestureRecognizer()..onTap = () => widget.onTap(e)).toList();
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
    return Text.rich(TextSpan(text: widget.description, children: topics),
        maxLines: 7,
        style: TextStyle(color: kPrimaryTextColor, fontSize: 15.toPadding, overflow: TextOverflow.ellipsis));
  }

  @override
  void dispose() {
    gestures.forEach((element) => element.dispose());
    super.dispose();
  }
}
