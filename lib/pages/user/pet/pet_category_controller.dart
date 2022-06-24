part of 'package:frontend/pages/user/pet/pet_category_page.dart';

extension PetHotSubCategory on PetCategory {
  List<PetSubCategory> get _hotArray =>
      subCategory.where((element) => hotCategory.map((e) => int2String(e)).contains(element.id)).toList();
}

/// 分类
class PetCategoryController extends GetxController {
  final PetCategory category;

  List<PetSubCategory> get hotSubCategories => category._hotArray;

  PetAddController get _petAdd => Get.find<PetAddController>();
  var searchResult = RxList<PetSubCategory>();

  final searchCtl = TextEditingController();

  PetCategoryController(this.category) {
    searchResult.value = category.subCategory;
  }

  void choseHotCategory(index) {
    _petAdd.choseCategory(PetExplicitCategory(category, category._hotArray[index]));
    Get.back();
  }

  void choseCategory(PetSubCategory sub) {
    _petAdd.choseCategory(PetExplicitCategory(category, sub));
    Get.back();
  }

  search() {
    if (searchCtl.text.isEmpty) {
      searchResult.value = category.subCategory;
      return;
    }
    searchResult.value = category.subCategory.where((str) => str.name.contains(searchCtl.text)).toList();
  }
}
