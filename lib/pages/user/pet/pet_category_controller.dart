part of 'package:frontend/pages/user/pet/pet_category_page.dart';

extension PetHotSubCategory on PetCategory {
  List<PetSubCategory> get _hotArray =>
      subCategory.where((element) => hotCategory.map((e) => int2String(e)).contains(element.id)).toList();
}

/// 分类
class PetCategoryController extends GetxController {
  final PetCategory category;

  List<PetSubCategory> get hotSubCategories => category._hotArray;

  var searchResult = RxList<PetSubCategory>();

  final searchCtl = TextEditingController();

  PetCategoryController(this.category) {
    searchResult.value = category.subCategory;
  }

  void choseHotCategory(index) {
    Get.back(result: PetExplicitCategory(category, category._hotArray[index]));
  }

  void choseCategory(PetSubCategory sub) {
    Get.back(result: PetExplicitCategory(category, sub));
  }

  search() {
    if (searchCtl.text.isEmpty) {
      searchResult.value = category.subCategory;
      return;
    }
    searchResult.value = category.subCategory.where((str) => str.name.contains(searchCtl.text)).toList();
  }
}
