import 'package:rmp/index_c.dart';
import 'package:rmp/services/utils.dart';

class SelectOrderPageCTR extends GetxController {
  bool isDelivery = false;
  List<CategorySL> categoryList = [];
  String total = '0.00';
  List<ProductsSL> listProduct = <ProductsSL>[];

  @override
  void onInit() {
    getCategoryWithProducts();
    super.onInit();
  }

  getCategoryWithProducts() {
    try {
      categoryList = categorySL.getAll();
      update(['getCategoryWithProducts']);
    } catch (e){
      suhErrorIN('SelectOrderPageCTR=>getCategoryWithProducts()', e);
    }
  }

  getProductsList() {
    listProduct = [];
    for (CategorySL cat in categoryList) {
      for (var pro in cat.products) {
        if (pro.isSelect) {
          listProduct.add(pro);
        }
      }
    }
    update(['getCategoryWithProducts']);
    update(['getProductsList']);
    update(['selectFormat']);
  }

  localOrder() {
    isDelivery = false;
    print(isDelivery);
    update(['isDeliveryID']);
  }

  deliveryOrder() {
    isDelivery = true;
    print(isDelivery);
    update(['isDeliveryID']);
  }

  listVisible({required int index}) {
    categoryList[index].isVisible = !categoryList[index].isVisible;
    update(['getCategoryWithProducts']);
  }

  onSelectOrder({required int index, required int index2}) {
    categoryList[index].products[index2].isSelect =
        !categoryList[index].products[index2].isSelect;
    if (categoryList[index].products[index2].isSelect == true) {
      productAdd(index: index, index2: index2);
    } else {
      categoryList[index].products[index2].num = 0;
    }
    update(['getCategoryWithProducts']);
    getTotal();
  }

  productAdd({required int index, required int index2}) {
    categoryList[index].products[index2].num += 1;
    if (categoryList[index].products[index2].num > 0) {
      categoryList[index].products[index2].isSelect = true;
    }
    getTotal();
    update(['getCategoryWithProducts']);
  }

  productDel({required int index, required int index2}) {
    if (categoryList[index].products[index2].num > 0) {
      categoryList[index].products[index2].num -= 1;
    }
    if (categoryList[index].products[index2].num == 0) {
      categoryList[index].products[index2].isSelect = false;
    }
    getTotal();
    update(['getCategoryWithProducts']);
  }

  addOrderInProList({required int index}) {
    listProduct[index].num += 1;
    print('listProduct[index].num=> ${listProduct[index].num}');
    getProductsList();
    getTotal();
  }

  delOrderInProList({required int index}) {
    if (listProduct[index].num > 0) {
      listProduct[index].num -= 1;
    }
    if (listProduct[index].num == 0) {
      listProduct[index].isSelect = false;
    }
    getProductsList();
    getTotal();
  }

  getTotal() {
    int t = 0;
    for (var element in categoryList) {
      for (var element in element.products) {
        if (element.isSelect) {
          t = t + int.parse(element.price ?? '0') * element.num;
        }
      }
    }
    total = t == 0 ? '0.00' : '$t';
    update(['getTotal']);
  }

  ///#######################|||
  /// OrderConfirmationPage |||
  ///#######################|||

  int invoiceFormat = 0;

  selectFormat(int i) {
    invoiceFormat = i;
    update(['selectFormat']);
  }
}
