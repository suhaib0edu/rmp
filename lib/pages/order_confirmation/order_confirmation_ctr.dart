import 'package:rmp/index_c.dart';
import 'package:rmp/services/utils.dart';

class OrderConfirmationPageCTR extends GetxController {
  List<ProductsSL> listProduct = <ProductsSL>[];
  List<ProductsOrderSL> listOrderP = <ProductsOrderSL>[];

  setOrder() {
    try {
      listOrderP = [];
      OrdersSL orderD = OrdersSL(
        date: DateTime.now(),
      );
      for (var e in listProduct) {
        ProductsOrderSL productsOrderSL = ProductsOrderSL(
          name: e.name,
          num: e.num,
          price: e.price,
          tax: e.tax,
          discount: e.discount,
        );
        listOrderP.add(
          productsOrderSL,
        );
      }
      orderD.products.addAll(listOrderP);

      orderSL.put(orderD);
      //InvoicePDF().generatePdf();
    } catch (e) {
      suhErrorIN('OrderConfirmationPageCTR=>setOrder()', e);
    }
  }
}
