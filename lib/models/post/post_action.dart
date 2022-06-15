import 'package:flutter/material.dart';

enum PostAction {
  share,
  comment,
  praise;

  IconData get icon {
    switch (this) {
      case PostAction.share:
        return Icons.share;
      case PostAction.comment:
        return Icons.comment;
      case PostAction.praise:
        return Icons.favorite_outline;
    }
  }

  IconData get accentIcon {
    switch (this) {
      case PostAction.share:
        return Icons.share;
      case PostAction.comment:
        return Icons.comment;
      case PostAction.praise:
        return Icons.favorite_outlined;
    }
  }
}