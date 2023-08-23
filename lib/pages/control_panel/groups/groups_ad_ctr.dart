import 'package:rmp/index_c.dart';
import 'package:rmp/services/utils.dart';
import 'package:rmp/widgets/suh_snack_bar.dart';
import '../../../services/local/models.dart';


class GroupsADCTR extends GetxController {
  TextEditingController categoryController = TextEditingController();
  List<CategoryDB> listCategory = [];


  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  addCategory() {
    try {
      if (categoryController.text.isNotEmpty) {
        CategoryDB category = CategoryDB(
            name: categoryController.text.toString()
        );
        categoryDB.put(category);
        Get.back();
      } else {
        SuhSnackBar.messageCheckFieldNotEmpty();
      }
    }catch(e){
      suhErrorIN('addCategory()', e);
    }
    getAllCategory();
  }

  editCategory(int id){
    CategoryDB? category = categoryDB.get(id);
    category!.name = categoryController.text;
    categoryDB.put(category);
    Get.back();
    getAllCategory();
  }

  getAllCategory(){
    listCategory = [];
    listCategory.addAll(categoryDB.getAll());
    update(['getAllCategory']);
  }

  deleteCategory(int id){
    categoryDB.remove(id);
    getAllCategory();
  }
}
