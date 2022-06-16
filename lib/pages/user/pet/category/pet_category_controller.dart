part of 'package:frontend/pages/user/pet/category/pet_category_page.dart';

// 大分类
class PetCategoryController extends GetxController {
  List<PetCategory> get categories => Get.arguments;

  String? loadImage(int index) {
    if (categories[index].subCategory.isEmpty) {
      return null;
    }
    return categories[index].subCategory.first.image.toImageResourceUrl;
  }

  void jumpToSub(int index) {
    Get.toNamed(AppRoutes.petSubCategory, arguments: categories[index]);
  }
}
