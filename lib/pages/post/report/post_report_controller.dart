
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostReportController extends GetxController {

  List<Map> reasons = [{'title':"内容违规",'subTitles':
  ['低俗色情','抄袭他人作品','涉嫌非法集资','广告软文'
    , '涉嫌违法犯罪','网络暴力','养老诈骗','其他诈骗行为',],'placeholder':''},
    {'title':"内容低质",'subTitles':
    ['内容重复','内容虚假','通篇质量差'
      ]},
    {'title':"未成年相关",'subTitles':
    ['侵犯未成年人权益']
    },
    {'title':"侵犯权益",'subTitles':
    ['抄袭我的作品','侵犯名誉/商誉','侵犯肖像权','侵犯隐私权'
    ]},
    {'title':"其他",'subTitles':
    ['推送文案错误','其他问题'
    ]},
  ];

  List<String> titles = ['选择举报理由','选择具体原因','举报描述','证明材料'];
  var  reasonIndex = 100.obs ;
 var reasonDetailIndex = 100.obs;
 RxBool shouldNext = false.obs;
 var selectedColor = Colors.white;
 var selectedBorderColor = Colors.black12;
 var assets = RxList<AssetEntity>();
 final reportDescCtr = TextEditingController();

  reportReasonSelect(int index) {
    if(index != reasonIndex.value) {
      reasonIndex.value = index;
     List subTitles = reasons[index]['subTitles'];
      reasonDetailIndex.value = subTitles.length == 1 ? 0 : 100;
      selectedColor = const Color(0x81f89502);
      shouldNext.value = subTitles.length== 1 ? true :false;
    }
  }
  reportReasonDetailSelect(int index) {
     if(index != reasonDetailIndex.value) {
       reasonDetailIndex.value = index;
       shouldNext.value = true;
     }
  }
  submitOnTap() {

  }




}