import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/keyboard_allocator.dart';
import 'package:frontend/components/mixins/load_image_mixin.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/pages/user/feedback/feedback_controller.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';


class FeedbackPage extends GetView<FeedbackController> with KeyboardAllocator ,ThemeMixin,LoadImageMixin {
  final descriptionNode = FocusNode();
  @override
  final controller = Get.put(FeedbackController());
  Color bgColor = const Color(0x30cccccc);
  FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title:const Text('意见反馈',style: TextStyle(color: Colors.white),),backgroundColor: Colors.black54,),
    body: SafeArea(
        child: KeyboardActions(
          config: doneKeyboardConfig( [descriptionNode]),
          child: SizedBox (
            height: Get.height - Get.statusBarHeight - kToolbarHeight,
            child:  Container(
                color: bgColor,
                child: Stack (
                  children: [
                    Container(
                      color:Color(0x30cccccc),
                      margin: EdgeInsets.only(bottom: 10),
                      child:  ListView (
                        children: [
                          _headerItem,
                          _listItem,
                          const SizedBox(height: 10,),
                          _feedbackTextView,
                          _imageAddItme,
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                    Positioned(bottom:15,child: _nextItem,)

                  ],
                )
            ),
          ),
        )
    ),

  );
  /*头部提示*/
  Widget get _headerItem => Container(

    color: Colors.white,
    width: Get.width,
    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),

    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Text('请选择反馈问题类型',style: TextStyle(fontSize:16 ,fontWeight: FontWeight.bold,),),
        const SizedBox(height: 5,),
        Text('选择反馈问题, 以便我们能够更快速的查找解决问题',style: TextStyle(fontSize: 14,color: kSecondaryTextColor)),

      ],
    ),
  );

  /*原因列表*/
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
    separatorBuilder: (BuildContext context, int index) {
      return const Divider(height: 0,indent: 15,endIndent: 15,color:Colors.black38,); },

  );
  /*问题描述*/
  Widget get _feedbackTextView => Container(
    color: Colors.white,
    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
    child:    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('问题描述',style: TextStyle(fontSize:16 ,fontWeight: FontWeight.bold,),),
        const SizedBox(height: 10,),
        TextField(
          focusNode: descriptionNode,
          controller: controller.feedbackCtl,
          maxLines: 5,
          maxLength: 200,
          cursorColor: Colors.black,
          onChanged: (_) => controller.update(['next']),
          decoration: const InputDecoration(
              hintText: '请填写您的意见和反馈说明',
              fillColor: Color(0x30cccccc),
              filled: true,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0x00000000), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000),
                  ))
          ),
        ),
      ],
    ),
  );


  Widget get _imageAddItme => GetBuilder<FeedbackController> (
      id: 'cover',
      builder: (_) => Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              height: 60,
              child: Row(
                  children: [
                    controller.covers.length == controller.maxAssets ? Row(
                      children: [
                        _localImage(controller.covers[0]),
                        const SizedBox(width: 10,),
                        _localImage(controller.covers[01]),],
                    ) : controller.covers.isEmpty ? _addBtn : Row(
                      children: [
                        _localImage(controller.covers[0]),
                        const SizedBox(width: 10,),
                        _addBtn
                      ],
                    )]
              ),
            ),
            const SizedBox(height: 10,),
            Text('提示：添加相关问题的照片或截图，能更快的解决问题',style: TextStyle(fontSize: kSmallFont,color: kGreyColor),)
          ],

        ),
      )
  );

/*添加的图片*/
  Widget  _localImage(AssetEntity entity) => ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child:  Image(image: AssetEntityImageProvider(entity),height: 60,width: 60,fit: BoxFit.fill,),
  );

  /*添加图片按钮*/
  Widget get _addBtn => ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child:  TextButton(
        onPressed: controller.choseCover,
        child: buildAssetImage('personal_blackAdd',width: 60)) ,
  );

/*确认按钮*/
  Widget get _nextItem => SizedBox(
      height: 64,
      width: Get.width,
      child:Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        color: Colors.white,
        child:  GetBuilder<FeedbackController>(
          id: 'next',
          builder: (_){
            final enable = controller.shouldNext;
            final color = controller.shouldNext ? kOrangeColor : Colors.grey;

            return ElevatedButton(
              onPressed: enable ? controller.feedback : null,
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
              child: Text('提交',style: (TextStyle(color: kBackgroundColor,fontSize: kButtonFont)),),

            );
          },
        ),
      )
  );

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
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 54,
        color: Colors.white,
        child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child:  Text(widget.title,
                  style: TextStyle(color: widget.isSelect ? kOrangeColor : kBlackColor,fontSize: kButtonFont),),
              ),
              widget.isSelect ? Icon(Icons.check_outlined,color: kOrangeColor,) : Container()
            ]),
      ),

    );

  }
}

