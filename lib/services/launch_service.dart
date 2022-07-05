import 'package:frontend/models/app_config.dart';
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


  AppConfigModel configModel = AppConfigModel(
      maxCommentDescription:'200' ,/// 最大评论字数
      maxIntroduction:'200' ,/// 最大介绍字数
      maxPetCount: '5' ,/// 宠物个数
      maxTopicDescription:'200' ,///主题描述最多字数
      maxTopicTitle: '50') ; /// 主题标题最大字数


  /// 注册流程:
  /// 用户基本信息 -> 至少一个宠物
  String? get isCompletedRegisterFlow {
    assert(user != null, '必须先登录, 才能进入注册流程');
    if (user!.hasPassword == false) return AppRoutes.loginSetPassword;
    if (user!.info == null) return AppRoutes.userInfoAdd;
    if (user!.petCount == 0) return AppRoutes.petAdd;
    return null;
  }

  Future init() async {
    isLogin = (await SharedPreferences.getInstance()).containsKey('token');
    user = isLogin ? (await User.cached())! : null;
    appConfig();

  }

  /// 退出登录
  Future restart() async {
    await Store.clear();
    await init();
    Get.offAllNamed(AppRoutes.login);
  }

  /// 登录
  void login(User user, String token) {
    updateUser(user);
    StoreToken.setToken(token);
  }

  /// 更新用户
  void updateUser(User user) {
    user.save();
    this.user = user;
  }

  /// 更新用户信息
  Future? refreshUserIfNeed() {
    if (!isLogin) return null;
    return get<UserInfo>('user/${user!.id}/', (data) => UserInfo.fromJson(data)).then((value) {
      user!.info = value;
      updateUser(user!);
    });
  }

  String get firstRoute => isLogin ? (isCompletedRegisterFlow ?? AppRoutes.scaffold) : AppRoutes.login;

  /// 获取配置信息
  void appConfig() async {

    get<AppConfigModel>('configuration/app/',(data) => AppConfigModel.fromJson(data)).then((value) {
      configModel = value ;
    });

  }
}
