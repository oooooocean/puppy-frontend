import 'package:frontend/net/net_mixin.dart';
import 'package:get/get.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/route/pages.dart';
import 'package:frontend/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchService with NetMixin {
  static final shared = LaunchService();

  /// 是否登录
  bool isLogin = false;

  User? user;

  String? get isCompletedRegisterFlow {
    assert(user != null, '必须先登录, 才能进入注册流程');
    if (user!.info == null) return AppRoutes.userInfoAdd;
    if (user!.petCount == 0) return AppRoutes.petAdd;
    return null;
  }

  Future init() async {
    isLogin = (await SharedPreferences.getInstance()).containsKey('token');
    user = isLogin ? (await User.cached())! : null;
  }

  Future restart() async {
    await Store.clear();
    await init();
    Get.offAllNamed(AppRoutes.login);
  }

  void login(User user, String token) {
    updateUser(user);
    StoreToken.setToken(token);
  }

  void updateUser(User user) {
    user.save();
    this.user = user;
  }

  Future refreshUser() {
    assert(user != null, '必须先登录, 才能进入刷新用户');
    return get<UserInfo>('user/${user!.id}/', (data) => UserInfo.fromJson(data)).then((value) {
      user!.info = value;
      updateUser(user!);
    });
  }

  String get firstRoute => isLogin ? (isCompletedRegisterFlow ?? AppRoutes.scaffold) : AppRoutes.login;
}
