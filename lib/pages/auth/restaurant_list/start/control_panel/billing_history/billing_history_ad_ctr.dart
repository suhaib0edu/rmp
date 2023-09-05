import 'package:rmp/index_c.dart';
import 'package:rmp/objectbox.g.dart';
import 'package:rmp/services/utils.dart';


class BillingHistoryADCTR extends GetxController {
  List<ProductsOrderSL> listOrder = [];
  List<ProductsSL> listOrderV = [];
  DateTime dateTime = DateTime.now();

  getInvoicesForToday() {
    try {
      listOrder = [];
      listOrderV = [];

      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      dateTime = startOfDay;
      //query=>
      final query = orderSL
          .query(OrdersSL_.date.between(
          startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch))
          .build()
          .find();
      getListOrderByQuery(query);
      listOrderV.addAll(getListOrderV());
    }catch(e){
      suhErrorIN('getInvoicesForToday()', e);
    }
  }

  getInvoicesForMonth() {
    try {
      listOrder = [];
      listOrderV = [];

      DateTime now = DateTime.now();
      DateTime startOfMonth = now.subtract(const Duration(days: 30));
      dateTime = startOfMonth;
      //query=>
      final query = orderSL
          .query(OrdersSL_.date.between(
          startOfMonth.millisecondsSinceEpoch, now.millisecondsSinceEpoch))
          .build()
          .find();
      getListOrderByQuery(query);
      listOrderV.addAll(getListOrderV());
    }catch(e){
      suhErrorIN('getInvoicesForMonth()', e);
    }
  }

  getInvoicesForYear() {
    try {
      listOrder = [];
      listOrderV = [];

      DateTime now = DateTime.now();
      DateTime startOfYear = now.subtract(const Duration(days: 365));
      dateTime = startOfYear;
      //query=>
      final query = orderSL
          .query(OrdersSL_.date.between(
          startOfYear.millisecondsSinceEpoch, now.millisecondsSinceEpoch))
          .build()
          .find();
      getListOrderByQuery(query);
      listOrderV.addAll(getListOrderV());
    }catch(e){
      suhErrorIN('getInvoicesForYear()', e);
    }
  }

  List<ProductsSL> getListOrderV() {
    List<ProductsSL> lv = [];
    try {
      final pros = productsSL.getAll();
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
    }catch(e){
      suhErrorIN('getListOrderV()', e);
    }
    return lv;
  }

  getListOrderByQuery(List<OrdersSL> query){
    try {
      for (var o in query) {
        for (ProductsOrderSL e in o.products) {
          ProductsOrderSL productsD = ProductsOrderSL(
            name: e.name.toString(),
            price: e.price.toString(),
            tax: e.tax.toString(),
            discount: e.discount.toString(),
            num: e.num,
          );
          listOrder.add(productsD);
        }
      }
    }catch(e){
      suhErrorIN('getListOrderByQuery()', e);
    }
  }
}
