import 'package:get/get.dart';
import 'package:rmp/index_c.dart';
import '../../services/local/models.dart';

class OrderConfirmationPageCTR extends GetxController {
  List<ProductsDB> listProduct = <ProductsDB>[];

  printOrder() {
    OrderDB orderD = OrderDB(
      isLocal: false,
      date: DateTime.now(),
      products: listProduct,
      cashier: 'محمد'
    );
    var x = orderDB.put(orderD);
    print(x);
    //InvoicePDF().generatePdf();
  }
}
