import 'package:flutter/material.dart';
import 'package:frontend/pages/post/report/post_report_controller.dart';
import 'package:get/get.dart';
import '../../../components/comps/puppy_button.dart';
import '../../../components/mixins/theme_mixin.dart';

class PostReportPage extends GetView<PostReportController> {
  const PostReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('举报')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: kSpacePadding, horizontal: kDefaultPadding),
          child: Column(
            children: [
              Expanded(
                  child: ListView(keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, children: [
                _titleItem('选择举报理由', isShowStar: true),
                _divider,
                _choiceChipTitleItem(),
                _divider,
                _detailsItem,
                _divider,
                _titleItem('举报描述'),
                _divider,
                _descriptionItem,
              ])),
              _submitItem
            ],
          ),
        ),
      ),
    );
  }

  Widget get _divider => SizedBox(height: kSpacePadding);

  Widget _titleItem(String title, {bool isShowStar = false}) {
    Widget child;
    if (isShowStar) {
      child = Row(children: [const Text('* ', style: TextStyle(color: Colors.red)), Text(title)]);
    } else {
      child = Text(title, style: const TextStyle(fontSize: kButtonFont, fontWeight: FontWeight.bold));
    }
    return DefaultTextStyle(
        style: const TextStyle(fontSize: kButtonFont, fontWeight: FontWeight.bold, color: kPrimaryTextColor),
        child: child);
  }

  /// 选择举报理由
  Widget _choiceChipTitleItem() => Obx(() => Wrap(
        spacing: kDefaultPadding,
        children: List.generate(
            controller.reasons.length,
            (index) => _buildChoiceItem(
                isSelected: controller.reasons[index].isSelected.value,
                text: controller.reasons[index].title,
                onSelected: () => controller.select(index))),
      ));

  /// 具体举报理由
  Widget get _detailsItem => GetBuilder<PostReportController>(
      id: 'subReason',
      builder: (_) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Visibility(visible: controller.hasSelectedReason, child: _titleItem('选择具体原因', isShowStar: true)),
            controller.hasSelectedReason ? _choiceChipDetailItem() : Container()
          ]));

  /// 理由GridView
  Widget _choiceChipDetailItem() => Wrap(
        spacing: kDefaultPadding,
        children: List.generate(controller.selectedReason.subtitles.length, (index) {
          final reason = controller.selectedReason;
          return _buildChoiceItem(
              isSelected: index == reason.subSelected,
              text: reason.subtitles[index],
              onSelected: () => controller.selectDetail(index));
        }),
      );

  /// 理由描述输入框
  Widget get _descriptionItem => TextField(
      controller: controller.reportDescCtl,
      maxLines: 5,
      maxLength: 100,
      decoration: const InputDecoration(hintText: '请描述你遇到的问题'));

  /// 提交按钮
  Widget get _submitItem => Obx(
        () => PuppyButton(
            onPressed: controller.shouldNext.value ? controller.submitOnTap : null,
            buttonStyle: ButtonStyle(fixedSize: MaterialStateProperty.all(Size.fromWidth(Get.width))),
            style: PuppyButtonStyle.style1,
            child: const Text('提交')),
      );

  Widget _buildChoiceItem({required bool isSelected, required String text, required VoidCallback onSelected}) {
    return ChoiceChip(
        label: Text(text, style: TextStyle(color: isSelected ? Colors.white : kPrimaryTextColor)),
        selected: isSelected,
        onSelected: (_) => onSelected(),
        selectedColor: kOrangeColor,
        backgroundColor: Colors.transparent,
        side: BorderSide.none);
  }
}
