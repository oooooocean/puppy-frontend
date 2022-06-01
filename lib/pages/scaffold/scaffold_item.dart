import 'package:flutter/material.dart';

enum ScaffoldItem {
  home,
  mine;

  @override
  String toString() {
    switch (this) {
      case ScaffoldItem.home:
        return "星球";
      case ScaffoldItem.mine:
        return "我的";
    }
  }

  IconData get iconData {
    switch (this) {
      case ScaffoldItem.home:
        return Icons.blur_circular;
      case ScaffoldItem.mine:
        return Icons.person;
    }
  }
}
