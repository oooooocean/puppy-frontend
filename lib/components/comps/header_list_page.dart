import 'package:flutter/material.dart';

typedef HeaderWidgetBuild = Widget Function(BuildContext context, int position);

typedef ItemWidgetBuild = Widget Function(BuildContext context, int position);

class HeaderListPage extends StatefulWidget {
  final List listData;
  final ItemWidgetBuild itemWidgetCreator;
  final HeaderWidgetBuild? headerCreator;

  const HeaderListPage(this.listData,
      {Key? key, required this.itemWidgetCreator, this.headerCreator})
      : super(key: key);

  @override
  ListPageState createState() {
    return ListPageState();
  }
}

class ListPageState extends State<HeaderListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int position) {
          return buildItemWidget(context, position);
        },
        itemCount: _getListCount());
  }

  int _getListCount() {
    return getHeaderCount() + widget.listData.length;
  }

  int getHeaderCount() {
    return 1;
  }

  Widget _headerItemWidget(BuildContext context, int index) {
    if (widget.headerCreator != null) {
      return widget.headerCreator!(context, index);
    } else {
      return GestureDetector(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Header Row $index")),
        onTap: () {},
      );
    }
  }

  Widget buildItemWidget(BuildContext context, int index) {
    if (index < getHeaderCount()) {
      return _headerItemWidget(context, index);
    } else {
      return _itemBuildWidget(context, index - getHeaderCount());
    }
  }

  Widget _itemBuildWidget(BuildContext context, int index) =>
      widget.itemWidgetCreator(context, index);
}
