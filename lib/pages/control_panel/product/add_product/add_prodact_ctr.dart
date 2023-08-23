import 'package:rmp/pages/control_panel/product/product_ad_ctr.dart';
import 'package:rmp/services/local/models.dart';
import 'package:rmp/pages/control_panel/groups/groups_ad_ctr.dart';
import 'package:rmp/services/utils.dart';
import 'package:rmp/widgets/suh_snack_bar.dart';
import '../../../../index_c.dart';

class AddProductPageCTR extends GetxController {
  GroupsADCTR groupsADCTR = Get.put(GroupsADCTR());
  ProductADCTR productADCTR = Get.put(ProductADCTR());
  bool visibleCategory = false;
  String selectCategory = 'حدد المجموعة';
  CategoryDB category = CategoryDB();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  int editID = 0;
  bool isEditP = false;

  @override
  void onInit() {
    groupsADCTR.getAllCategory();
    taxController.text='0';
    discountController.text='0';
    super.onInit();
  }

  addProduct() async {
    try {
      if (areAllFieldsNotEmpty() && category.id > 0) {
        ProductsDB product = ProductsDB(
            name: nameController.text,
            price: priceController.text,
            tax: taxController.text,
            discount: discountController.text);
        CategoryDB? categoryD = categoryDB.get(category.id);

        if (categoryD != null) {
          if (!isEditP) {
            categoryD.products.add(product);
            categoryDB.put(categoryD);
          } else {
            var pro = productsDB.get(editID);
            if (pro != null) {
              pro.price = product.price;
              productsDB.put(pro);
            }
          }
          productADCTR.getAllProducts();
          Get.back();
        }
      } else {
        SuhSnackBar.messageCheckFieldNotEmpty();
      }
    } catch (e) {
      suhErrorIN('addProduct()', e);
    }
  }

  void editProduct({required ProductsDB? editProduct}) {
    if (editProduct != null) {
      nameController.text = editProduct.name.toString();
      priceController.text = editProduct.price.toString();
      discountController.text = editProduct.discount.toString();
      taxController.text = editProduct.tax.toString();
      editID = editProduct.id;
      isEditP = true;
    }
  }

  bool areAllFieldsNotEmpty() {
    bool isNameEmpty = nameController.text.isEmpty;
    bool isPriceEmpty = priceController.text.isEmpty;
    bool isTaxEmpty = taxController.text.isEmpty;
    bool isDiscountEmpty = discountController.text.isEmpty;
    return !isNameEmpty && !isPriceEmpty && !isTaxEmpty && !isDiscountEmpty;
  }
}
