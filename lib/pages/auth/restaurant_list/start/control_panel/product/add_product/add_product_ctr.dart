import '../../../../../../../index_c.dart';
import '../../../../../../../services/utils.dart';
import '../../../../../../../widgets/suh_snack_bar.dart';
import '../../groups/groups_ad_ctr.dart';
import '../product_ad_ctr.dart';

class AddProductPageCTR extends GetxController {
  GroupsADCTR groupsADCTR = Get.put(GroupsADCTR());
  ProductADCTR productADCTR = Get.put(ProductADCTR());
  bool visibleCategory = false;
  String selectCategory = 'حدد المجموعة';
  CategorySL category = CategorySL();
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
        ProductsSL product = ProductsSL(
            name: nameController.text,
            price: priceController.text,
            tax: taxController.text,
            discount: discountController.text);
        CategorySL? categoryD = categorySL.get(category.id);

        if (categoryD != null) {
          if (!isEditP) {
            categoryD.products.add(product);
            categorySL.put(categoryD);
          } else {
            var pro = productsSL.get(editID);
            if (pro != null) {
              pro.price = product.price;
              productsSL.put(pro);
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

  void editProduct({required ProductsSL? editProduct}) {
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
