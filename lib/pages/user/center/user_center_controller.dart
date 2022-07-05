import 'package:frontend/models/pet/pet.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/pages/social/social_action_mixin.dart';
import 'package:frontend/pages/user/center/user_center_post_controller.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

typedef UserCenterData = Tuple2<User, List<Pet>>;

class UserCenterController extends GetxController with StateMixin<UserCenterData>, NetMixin, SocialActionMixin {
  final int userId;

  UserCenterController(this.userId);

  /// 用户信息
  User get user => state!.first;

  /// 宠物信息
  List<Pet> get pets => state!.second;

  bool get isLoginUser => false;

  onTapPraise() {}

  onTapFans() {}

  onTapIdols() {}

  onTapPet(Pet pet) {}

  /// 关注
  onTapFollow() async {
    final result = await follow(followId: userId, isCancel: user.social.hasFollow.value);
    if (!result) return;
    user.social.hasFollow.value = !user.social.hasFollow.value;
  }

  @override
  void onReady() {
    change(null, status: RxStatus.loading());
    Future.wait([
      get('user/$userId/', (data) => User.fromJson(data)),
      get('user/$userId/pets/', (data) => (data as List<dynamic>).map((e) => Pet.fromJson(e)).toList())
    ]).then((value) {
      change(UserCenterData(value[0] as User, value[1] as List<Pet>), status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });

    Get.lazyPut(() => CenterPostController(userId));
    super.onReady();
  }
}

class LoginUserCenterController extends UserCenterController {
  LoginUserCenterController(super.userId);

  @override
  bool get isLoginUser => true;

  /// 修改头像
  onSelectedAvatar(AssetEntity assetEntity) {}

  onTapEdit() {}
}
