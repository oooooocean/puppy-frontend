import 'dart:async';

import 'package:frontend/net/net_mixin.dart';

mixin SocialActionMixin on NetMixin {
  /// 关注
  Future<bool> follow({required int followId, required bool isCancel}) {
    final completer = Completer<bool>();
    request(
        api: () => isCancel
            ? delete('follow/$followId/', null, (data) => data)
            : post('follow/', {'follow_id': followId.toString()}, (data) => data),
        success: (_) => completer.complete(true),
        fail: (_) => completer.complete(false));
    return completer.future;
  }
}
