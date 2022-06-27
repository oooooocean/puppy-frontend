import 'package:flutter/cupertino.dart';
import 'package:frontend/components/mixins/refresh_mixin.dart';
import 'package:frontend/models/paging_data.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';

class IdolListController extends GetxController with RefreshMixin<BaseUser>, NetMixin {
  final searchCtl = TextEditingController();

  @override
  void onReady() {
    startRefresh(RefreshType.refresh).then((value) => update());
    super.onReady();
  }

  @override
  Future<PagingData<BaseUser>> get refreshRequest =>
      get('follow/', (data) => PagingData.fromJson(data, (json) => BaseUser.fromJson(json)), query: {'page': paging.current.toString()});
}
