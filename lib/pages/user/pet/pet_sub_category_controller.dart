part of 'package:frontend/pages/user/pet/pet_sub_category_page.dart';

// 子分类
class PetSubCategoryController extends GetxController {
  PetCategory category = Get.arguments;
  PetAddController get petAdd => Get.find<PetAddController>();

  void choseCategory(index) {
    petAdd.choseCategory(
        PetExplicitCategory(category, category.subCategory[index]));
    Get.back();
  }
}
