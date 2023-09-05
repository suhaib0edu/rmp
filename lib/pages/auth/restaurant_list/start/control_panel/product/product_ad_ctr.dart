import 'package:rmp/index_c.dart';

import 'add_product/add_product.dart';

class ProductADCTR extends GetxController {
  List<ProductsSL> productList = [];

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  deleteProduct(int id) {
    productsSL.remove(id);
    getAllProducts();
  }

  getAllProducts() {
    productList = [];
    categorySL.getAll().forEach((element) {
      for (ProductsSL e in element.products) {
        productList.add(ProductsSL(
          name: e.name,
          price: e.price,
          tax: e.tax,
          discount: e.discount,
        ));
      }});
    update(['getAllProducts']);
  }

  editProduct(int id) {
    var p = productsSL.get(id);
    Get.to(() => AddProductPage(
          editProduct: p,
        ));
  }
}
