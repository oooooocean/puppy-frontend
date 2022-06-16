part of 'package:frontend/pages/user/pet/category/pet_search_page.dart';

extension FilterString on String {
  bool vagueSearch(String text) {
    return indexOf(text) > -1;
  }
}

/// 搜索控制器
class PetSearchController extends GetxController {
  bool get hasSearched => _searchedText.isNotEmpty;
  List<PetSubCategory> searchedList = [];

  String _searchedText = "";
  final PetCategory _category = Get.arguments;
  PetAddController get _petAdd => Get.find<PetAddController>();

  void search(String text) {
    _searchedText = text;
    searchedList.clear();
    if (text.isEmpty) {
      update(["list"]);
      return;
    }
    searchedList.addAll(
        _category.subCategory.where((str) => str.name.vagueSearch(text)));
    update(["list"]);
  }

  void choseCategory(index) {
    _petAdd.choseCategory(PetExplicitCategory(_category, searchedList[index]));
    Get.close(3);
  }
}
