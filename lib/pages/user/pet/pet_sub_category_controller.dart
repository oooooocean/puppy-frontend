part of 'package:frontend/pages/user/pet/pet_sub_category_page.dart';

extension PetHotSubCategory on PetCategory {
  List<PetSubCategory>? get _hotArray => subCategory
      .where((element) =>
      hotCategory.map((e) => int2String(e)).contains(element.id))
      .toList();
}

// 子分类
class PetSubCategoryController extends GetxController {
  PetCategory category = Get.arguments;
  List<PetSubCategory>? get hotSubCategories => category._hotArray;
  PetAddController get _petAdd => Get.find<PetAddController>();

  String? loadHotImage(int index) {
    if (hotSubCategories != null && hotSubCategories!.isEmpty) {
      return null;
    }
    return hotSubCategories![index].image.toImageResourceUrl;
  }

  void choseHotCategory(index) {
    _petAdd.choseCategory(
        PetExplicitCategory(category, category._hotArray![index]));
    Get.back();
  }

  void choseCategory(index) {
    _petAdd.choseCategory(
        PetExplicitCategory(category, category.subCategory[index]));
    Get.back();
  }

}
