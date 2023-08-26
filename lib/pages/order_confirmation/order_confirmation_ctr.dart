import 'package:rmp/index_c.dart';
import 'package:rmp/services/utils.dart';

class OrderConfirmationPageCTR extends GetxController {
  List<ProductsDB> listProduct = <ProductsDB>[];
  List<ProductsForOrderDB> listOrderP = <ProductsForOrderDB>[];

  setOrder() {
    try {
      OrderDB orderD = OrderDB(
        isLocal: false,
        date: DateTime.now(),
        cashier: 'محمد',
        pName: listProduct.map((e) => e.name.toString()).toList(),
        pNum: listProduct.map((e) => e.num).toList(),
        pPrice: listProduct.map((e) => e.price.toString()).toList(),
        pTax: listProduct.map((e) => e.tax.toString()).toList(),
        pDiscount: listProduct.map((e) => e.discount.toString()).toList(),
      );
      for (var e in listProduct) {
        listOrderP.add(
          ProductsForOrderDB(
            name: e.name,
            num: e.num,
            price: e.price,
            tax: e.tax,
            discount: e.discount,
          ),
        );
      }
      orderD.products.addAll(listOrderP);
      orderDB.put(orderD);
      //InvoicePDF().generatePdf();
    } catch (e) {
      suhErrorIN('setOrder()', e);
    }
  }
}
