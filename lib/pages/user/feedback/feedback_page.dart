import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/user/feedback/feedback_controller.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../components/comps/puppy_text_field.dart';

class FeedbackPage extends GetView<FeedbackController> with KeyboardAllocator ,ThemeMixin {
  final descriptionNode = FocusNode();
  final controller = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title:const Text('意见反馈'),),
    body: SafeArea(
        child: KeyboardActions(
      config: doneKeyboardConfig( [descriptionNode]),
      child: SizedBox (
        height: Get.height - Get.statusBarHeight - kToolbarHeight,
        child: Padding (
          padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 20),
          child: Column (
            children: [
              _headerItem,
              SizedBox(height: 5,),
              _listItem,

            ],
          ),
        ),
      ),
    )
    ),


  );

  Widget get _headerItem => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      const Text('请选择反馈问题类型',style: TextStyle(fontSize:18 ,fontWeight: FontWeight.bold,),),
      const SizedBox(height: 5,),
      Text('选择反馈问题, 以便我们能够更快速的查找解决问题',style: TextStyle(fontSize: 16,color: kSecondaryTextColor)),

    ],
  );

  Widget get _listItem => ListView.separated(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemBuilder: (BuildContext context, int index) => GetBuilder<FeedbackController> (
    id: 'listView',
    builder: (_) => FeedbackCell(title: controller.itmeDescs[index],
      opTap: ()=> controller.selectCell(index),
      isSelect: controller.selectIndex == index ? true : false,
    ),

  ),
    itemCount: controller.itmeDescs.length,
    separatorBuilder: (BuildContext context, int index) { return const Divider(); },

  );

  // Widget get _feedbackTextView =>


}

class FeedbackCell extends StatefulWidget {
  final String title;
  final bool isSelect;
  final VoidCallback? opTap;
  const FeedbackCell({super.key, required this.title, this.opTap,required this.isSelect});

  @override
  State<FeedbackCell> createState() => _FeedbackCellState();
}

class _FeedbackCellState extends State<FeedbackCell> with ThemeMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: widget.opTap,
     child: Container(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
          Container(
         height: 44,
         alignment: Alignment.centerLeft,
         child:  Text('${widget.title}',
           style: TextStyle(color: widget.isSelect ? kOrangeColor : kBlackColor,fontSize: kButtonFont),),
       ),
           widget.isSelect ? Icon(Icons.check_outlined,color: kOrangeColor,) : Container()
         ],
       ),
     ),

    );

  }
}

