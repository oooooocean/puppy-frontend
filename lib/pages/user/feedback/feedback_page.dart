import 'dart:core';

import 'package:flutter/material.dart';
import 'package:frontend/components/comps/comps.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/user/feedback/feedback_controller.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:frontend/components/extension/int_extension.dart';

class FeedbackPage extends GetView<FeedbackController> with KeyboardAllocator, ThemeMixin, LoadImageMixin {
  final descriptionNode = FocusNode();

  FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('意见反馈')),
        body: SafeArea(
            child: KeyboardActions(
          disableScroll: true,
          config: doneKeyboardConfig([descriptionNode]),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _headerItem,
                    ..._listItem,
                    _divider,
                    _feedContentItem,
                    _divider,
                  ],
                ),
              ),
              _nextItem
            ],
          ),
        )),
      );

  Widget get _divider => Divider(color: kDividerColor, height: 10.toPadding, thickness: 10.toPadding);

  /// 头部提示
  Widget get _headerItem => Padding(
      padding: EdgeInsets.all(15.toPadding),
      child: const Text.rich(
          TextSpan(text: '请选择反馈问题类型', style: TextStyle(fontSize: kAccentFont, fontWeight: FontWeight.bold), children: [
        TextSpan(
            text: '\n选择反馈问题, 以便我们能够更快速的查找解决问题',
            style: TextStyle(fontSize: kSmallFont, color: kSecondaryTextColor, fontWeight: FontWeight.normal))
      ])));

  /// 原因列表
  List<Widget> get _listItem => controller.reasonCategories.map((e) {
        return _feedbackCategoryItemBuilder(e, controller.selectCategory.value == e, () => controller.selectCell(e));
      }).toList();

  Widget _feedbackCategoryItemBuilder(String title, bool hasDivider, VoidCallback onTap) {
    final cell = GetBuilder<FeedbackController>(
      id: 'listView',
      builder: (_) {
        return FeedbackTile(title: title, opTap: onTap, isSelect: title == controller.selectCategory.value);
      },
    );
    if (!hasDivider) return cell;
    return Column(mainAxisSize: MainAxisSize.min, children: [cell, const Divider(height: 1)]);
  }

  /// 反馈内容
  Widget get _feedContentItem => Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.toPadding),
          child: const Text('问题描述', style: TextStyle(fontSize: kAccentFont, fontWeight: FontWeight.bold)),
        ),
        TextField(
          focusNode: descriptionNode,
          controller: controller.feedbackCtl,
          maxLines: 5,
          maxLength: 200,
          onChanged: (_) => controller.update(['next']),
          decoration: const InputDecoration(
              fillColor: kShapeColor, filled: true, hintText: '请填写您的意见和反馈说明', enabledBorder: InputBorder.none),
        ),
        _imageAddItem,
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.toPadding),
          child: Text('提示：添加相关问题的照片或截图，能更快的解决问题', style: TextStyle(fontSize: kSmallFont, color: kGreyColor)),
        )
      ]));

  /// 选择图片
  Widget get _imageAddItem => SizedBox(
        height: 60,
        child: GetBuilder<FeedbackController>(
            id: 'cover',
            builder: (_) {
              final images = controller.covers.map(_localImage).toList();
              if (controller.covers.length < controller.maxAssets) images.add(_addBtn);
              return Row(children: images);
            }),
      );

  Widget _localImage(AssetEntity entity) => Padding(
        padding: EdgeInsets.only(right: 8.toPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.toPadding),
          child: AspectRatio(aspectRatio: 1, child: Image(image: AssetEntityImageProvider(entity), fit: BoxFit.cover)),
        ),
      );

  /// 添加图片按钮
  Widget get _addBtn => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextButton(
            onPressed: controller.choseCover, child: Icon(Icons.add_a_photo_rounded, size: 60, color: kGreyColor)),
      );

  /// 提交按钮
  Widget get _nextItem => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.toPadding),
        child: GetBuilder<FeedbackController>(
            id: 'next',
            builder: (_) => PuppyButton(
                onPress: controller.shouldNext ? controller.feedback : null,
                style: PuppyButtonStyle.style1,
                child: const Text('提交'))),
      );
}

class FeedbackTile extends StatefulWidget {
  final String title;
  final bool isSelect;
  final VoidCallback? opTap;

  const FeedbackTile({super.key, required this.title, this.opTap, required this.isSelect});

  @override
  State<FeedbackTile> createState() => _FeedbackTileState();
}

class _FeedbackTileState extends State<FeedbackTile> with ThemeMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.opTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 54,
        color: Colors.white,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(color: widget.isSelect ? kOrangeColor : kBlackColor, fontSize: kButtonFont),
            ),
          ),
          widget.isSelect
              ? Icon(
                  Icons.check_outlined,
                  color: kOrangeColor,
                )
              : Container()
        ]),
      ),
    );
  }
}
