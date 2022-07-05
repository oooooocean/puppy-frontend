import 'package:frontend/models/pet/pet.dart';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/net/net_mixin.dart';
import 'package:frontend/pages/user/center/center_post_controller.dart';
import 'package:get/get.dart';
import 'package:more/more.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

typedef UserCenterData = Tuple2<User, List<Pet>>;

class CenterController extends GetxController with StateMixin<UserCenterData>, NetMixin {
  final int userId;

  CenterController(this.userId);

  User get user => state!.first;

  List<Pet> get pets => state!.second;

  onTapPraise() {}

  onTapFans() {}

  onTapIdols() {}

  onSelectedAvatar(AssetEntity assetEntity) {}

  onTapEdit() {}

  onTapPet(Pet pet) {}

  onTapFollow() {}

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
