part of 'package:frontend/pages/user/pet/category/pet_category_page.dart';

/// 宠物大分类
class PetCategoryController extends GetxController {
  final List<PetCategory> categories;

  PetCategoryController(this.categories);

  String loadImage(int index) => categories[index].subCategory.first.image.toImageResourceUrl;

  void jumpToSub(int index) => Get.toNamed(AppRoutes.petSubCategory, arguments: categories[index]);
}
