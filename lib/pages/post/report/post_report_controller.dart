import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../models/post/post.dart';

class ReportReason {
  final String title;
  final List<String> subtitles;
  var isSelected = false.obs;
  int? subSelected;

  ReportReason(this.title, this.subtitles);
}

class PostReportController extends GetxController with NetMixin {
  final int postId;

  PostReportController(this.postId);

  List<ReportReason> reasons = [
    ReportReason('内容违规', ['低俗色情', '抄袭他人作品', '涉嫌非法集资', '广告软文', '涉嫌违法犯罪', '网络暴力', '养老诈骗', '其他诈骗行为']),
    ReportReason('内容低质', ['内容重复', '内容虚假', '通篇质量差']),
    ReportReason('未成年相关', ['侵犯未成年人权益']),
    ReportReason('侵犯权益', ['抄袭我的作品', '侵犯名誉/商誉', '侵犯肖像权', '侵犯隐私权']),
    ReportReason('其他', ['推送文案错误', '其他问题'])
  ];

  List<String> titles = ['选择举报理由', '选择具体原因', '举报描述', '证明材料'];

  RxBool shouldNext = false.obs;
  final reportDescCtl = TextEditingController();

  /// 举报理由选择
  select(int index) {
    final reason = reasons[index];
    if (reason.isSelected.value) return;
    for (var element in reasons) {
      element.isSelected.value = element == reason;
      element.subSelected = null;
    }
    if (reason.subtitles.length == 1) {
      reason.subSelected = 0;
    }

    update(['subReason']);
    shouldEnableNext();
  }

  /// 具体理由选择
  selectDetail(int index) {
    final reason = reasons.firstWhere((element) => element.isSelected.value);
    reason.subSelected = index;

    update(['subReason']);
    shouldEnableNext();
  }

  submitOnTap() {
    final reason = selectedReason;
    final desc = reportDescCtl.text;

    request(
        api: () => post(
            'post/$postId/complain/',
            {
              'description': [reason.title, reason.subtitles[reason.subSelected!], desc].join('_')
            },
            (data) => data),
        success: (_) {
          EasyLoading.showToast('感谢您的反馈, 我们会尽快处理~');
          Get.back();
        });
  }

  shouldEnableNext() {
    shouldNext.value = reasons.where((element) => element.subSelected != null).isNotEmpty;
  }

  bool get hasSelectedReason => reasons.where((element) => element.isSelected.value).isNotEmpty;

  ReportReason get selectedReason => reasons.firstWhere((element) => element.isSelected.value);
}
