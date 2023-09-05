import 'package:rmp/index_c.dart';
import 'package:rmp/services/utils.dart';
import 'package:rmp/widgets/suh_snack_bar.dart';
import '../../../services/local/models.dart';


class GroupsADCTR extends GetxController {
  TextEditingController categoryController = TextEditingController();
  List<CategorySL> listCategory = [];


  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  addCategory() {
    try {
      if (categoryController.text.isNotEmpty) {
        CategorySL category = CategorySL(
            name: categoryController.text.toString()
        );
        categorySL.put(category);
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
    CategorySL? category = categorySL.get(id);
    category!.name = categoryController.text;
    categorySL.put(category);
    Get.back();
    getAllCategory();
  }

  getAllCategory(){
    listCategory = [];
    listCategory.addAll(categorySL.getAll());
    update(['getAllCategory']);
  }

  deleteCategory(int id){
    categorySL.remove(id);
    getAllCategory();
  }
}
