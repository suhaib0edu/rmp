import 'package:rmp/index_c.dart';
import 'package:rmp/objectbox.g.dart';

class BillingHistoryADCTR extends GetxController {
  List<ProductsDB> listOrder = [];
  List<ProductsDB> listOrderV = [];

  getInvoicesForToday() {
    listOrder = [];
    listOrderV = [];

    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    //query=>
    final query = orderDB
        .query(OrderDB_.date.between(
            startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch))
        .build()
        .find();

    for (var e in query) {
      for (var i = 0; e.pName.length > i; i++) {
        ProductsDB productsD = ProductsDB(
          name: e.pName[i].toString(),
          price: e.pPrice[i].toString(),
          tax: e.pTax[i].toString(),
          discount: e.pDiscount[i].toString(),
          num: e.pNum[i],
        );
        listOrder.add(productsD);
      }
    }
    listOrderV.addAll(getListOrderV());
  }

  getInvoicesForMonth() {
    listOrder = [];
    listOrderV = [];

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.month));

    //query=>
    final query = orderDB
        .query(OrderDB_.date.between(
            startOfWeek.millisecondsSinceEpoch, now.millisecondsSinceEpoch))
        .build()
        .find();

    for (var e in query) {
      for (var i = 0; e.pName.length > i; i++) {
        ProductsDB productsD = ProductsDB(
          name: e.pName[i].toString(),
          price: e.pPrice[i].toString(),
          tax: e.pTax[i].toString(),
          discount: e.pDiscount[i].toString(),
          num: e.pNum[i],
        );
        listOrder.add(productsD);
      }
    }

    listOrderV.addAll(getListOrderV());
  }

  getInvoicesForYear() {
    listOrder = [];
    listOrderV = [];

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.year));

    //query=>
    final query = orderDB
        .query(OrderDB_.date.between(
            startOfWeek.millisecondsSinceEpoch, now.millisecondsSinceEpoch))
        .build()
        .find();

    for (var e in query) {
      for (var i = 0; e.pName.length > i; i++) {
        ProductsDB productsD = ProductsDB(
          name: e.pName[i].toString(),
          price: e.pPrice[i].toString(),
          tax: e.pTax[i].toString(),
          discount: e.pDiscount[i].toString(),
          num: e.pNum[i],
        );
        listOrder.add(productsD);
      }
    }

    listOrderV.addAll(getListOrderV());
  }

  List<ProductsDB> getListOrderV() {
    List<ProductsDB> lv = [];
    final pros = productsDB.getAll();
    for (var pro in pros) {
      for (var order in listOrder) {
        if (pro.name.toString().contains(order.name.toString())) {
          pro.num++;
        }
      }
      if (pro.num > 0) {
        lv.add(pro);
      }
    }
    return lv;
  }
}
