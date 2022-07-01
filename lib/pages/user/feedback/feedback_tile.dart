import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/mixins/theme_mixin.dart';

class FeedbackTile extends StatefulWidget {
  final String title;
  final bool isSelect;
  final VoidCallback? onTap;

  const FeedbackTile({super.key, required this.title, this.onTap, required this.isSelect});

  @override
  State<FeedbackTile> createState() => _FeedbackTileState();
}

class _FeedbackTileState extends State<FeedbackTile> with ThemeMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 54,
        color: kBackgroundColor,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(color: widget.isSelect ? kOrangeColor : kBlackColor, fontSize: kButtonFont),
            ),
          ),
          widget.isSelect
              ? const Icon(
            Icons.check_outlined,
            color: kOrangeColor,
          )
              : Container()
        ]),
      ),
    );
  }
}
