import 'package:rmp/index_c.dart';
import 'package:rmp/services/local/models.dart';

import 'add_product/add_product.dart';

class ProductADCTR extends GetxController {
  List<ProductsDB> productList = [];

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  deleteProduct(int id) {
    productsDB.remove(id);
    getAllProducts();
  }

  getAllProducts() {
    productList = [];
    categoryDB.getAll().forEach((element) {
      for (var element in element.products) {
        productList.add(element);
      }});
    update(['getAllProducts']);
  }

  editProduct(int id) {
    var p = productsDB.get(id);
    Get.to(() => AddProductPage(
          editProduct: p,
        ));
  }
}
