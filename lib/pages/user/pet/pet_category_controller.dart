part of 'package:frontend/pages/user/pet/pet_category_page.dart';

// 大分类
class PetCategoryController extends GetxController {
  List<PetCategory> get categories => Get.arguments;
}
