import 'package:flutter/material.dart';
import 'package:frontend/components/extension/int_extension.dart';
import 'package:frontend/pages/post/report/post_report_controller.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';

import '../../../components/comps/puppy_button.dart';
import '../../../components/comps/puppy_photo_picker.dart';
import '../../../components/mixins/theme_mixin.dart';

class PostReportPage extends GetView<PostReportController> {
  const PostReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:const Text('举报'),),
      body: Padding(
        padding:  EdgeInsets.all(15.toPadding),
        child:  Column(
          children: [

            Expanded(
              child: ListView(
                children: [
                  _titleItem(true, controller.titles[0]),
                  _choiceChipTitleItem(),
                  ..._detailsItem,
                  _titleItem(false, controller.titles[2]),
                  _descriptionItem,
                  _titleItem(false, controller.titles[3]),
                  _spaceHeightWidget,
                  _chosePhotoItem,
                ],
              ),
            ),
            _submitItem,
            _spaceHeightWidget
          ],
        ),
      ),
    );
  }

 Widget get _spaceHeightWidget => const SizedBox(height: 15,);

  Widget _titleItem(bool isShowStar,String title) {

    if (isShowStar) {
      return RichText(text: TextSpan(children: <InlineSpan>[
      const TextSpan(text:'* ',style: TextStyle(color: Colors.red,fontSize: kButtonFont,fontWeight: FontWeight.bold) ),
      TextSpan(text: title,style:const TextStyle(color: kBlackColor,fontSize: kButtonFont,fontWeight: FontWeight.bold))]),
      );
    } else {
      return Text(title,style: const TextStyle(fontSize:kButtonFont,fontWeight: FontWeight.bold),);
    }
  }

  Widget _choiceChipTitleItem() =>Obx(() => Padding(
    padding: EdgeInsets.symmetric(vertical: 15.toPadding),
    child: Wrap(
      spacing: 15,
      // alignment: WrapAlignment.spaceAround,
      children:  List.generate(controller.reasons.length, (index) {
        return ChoiceChip(label: Text( controller.reasons[index]['title']),
            selected: index == controller.reasonIndex.value,
            onSelected:(v) {
              controller.reportReasonSelect(index);
            },
          selectedColor: controller.selectedColor,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side:  BorderSide(
              width: 1,
              color:index == controller.reasonIndex.value ?kOrangeColor: controller.selectedBorderColor,
              style: BorderStyle.solid,
            ),
          ),
        );
      }),
    ),
  ));
  List<Widget> get _detailsItem => [
    Obx(() =>  controller.reasonIndex.value < 100 ?  _titleItem(true, controller.titles[1]) : Container()),
    Obx(() =>  controller.reasonIndex.value < 100 ? _choiceChipDetailItem(controller.reasonIndex.value ) : Container()),
  ];
  /// 理由GridView
  Widget _choiceChipDetailItem(int selectIndex) => Padding(
    padding:  EdgeInsets.symmetric(vertical: 15.toPadding),
    child: Wrap(
      spacing: 15,
      children: List.generate((controller.reasons[selectIndex]['subTitles'] as List).length, (index) {
        return ChoiceChip(label: Text( (controller.reasons[selectIndex]['subTitles'] as List)[index]),
          selected: index == controller.reasonDetailIndex.value,
          onSelected:(v) {
            controller.reportReasonDetailSelect(index);
          },
          selectedColor: controller.selectedColor,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side:  BorderSide(
              width: 1,
              color:index == controller.reasonDetailIndex.value ?kOrangeColor: controller.selectedBorderColor,
              style: BorderStyle.solid,
            ),
          ),
        );
      }),
    ),
  );
  /// 理由描述输入框
  Widget get _descriptionItem => TextField(
    controller: controller.reportDescCtr,
    maxLines: 5,
    maxLength: 200,
    onChanged: (_) => controller.update(['next']),
    decoration: const InputDecoration(hintText: '请描述你遇到的问题'),
  );
  /// 选择证明图片
  Widget get _chosePhotoItem => PuppyAssetsPicker(
      limit: 3,
      assetsChanged: (assets) {
        controller.assets.value = assets;
        controller.update(['publish']);
      });
 Widget get _submitItem =>  Obx(() => PuppyButton(
       onPressed: controller.shouldNext.isTrue ? controller.submitOnTap : null,
       style: PuppyButtonStyle.style1,
       child: const Text('提交', style: TextStyle(fontSize: kButtonFont, fontWeight: FontWeight.w600))),);



}