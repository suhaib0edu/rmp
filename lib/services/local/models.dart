import 'package:flutter/cupertino.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserDB {
  @Id()
  int id;
  String? serverID;
  String? username;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? country;
  String? state;
  String? city;
  String? restaurantName;
  String? lastLogin;
  String? dateJoined;

  UserDB({
    this.id = 0,
    this.serverID,
    this.username,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.country,
    this.state,
    this.city,
    this.restaurantName,
    this.lastLogin,
    this.dateJoined,
  });
}

@Entity()
class CategoryDB {
  @Id()
  int id;
  String? serverID;
  @Unique()
  String? name;
  final products = ToMany<ProductsDB>();
  bool isVisible;

  CategoryDB({
    this.id = 0,
    this.serverID,
    this.name,
    this.isVisible = false,
  });
}

@Entity()
class ProductsDB {
  @Id()
  int id;
  String? serverID;
  String? name;
  String? price;
  String? tax;
  String? discount;
  UserDB? owner;
  int num;
  bool isSelect;
  TextEditingController? controller;

  ProductsDB(
      {this.id = 0,
      this.serverID,
      this.name,
      this.price,
      this.tax,
      this.discount,
      this.owner,
      this.num = 0,
      this.isSelect = false,
      this.controller});
}

@Entity()
class OrderDB {
  @Id()
  int id;
  String? serverID;
  bool isLocal;
  DateTime? date;
  String? cashier;
  @Backlink('order')
  final products = ToMany<ProductsForOrderDB>();
  List<String> pName;
  List<int> pNum;
  List<String> pPrice;
  List<String> pTax;
  List<String> pDiscount;

  OrderDB({
    this.id = 0,
    this.serverID,
    this.isLocal = false,
    this.date,
    this.cashier,
    required this.pName,
    required this.pNum,
    required this.pPrice,
    required this.pTax,
    required this.pDiscount,
  });
}

@Entity()
class ProductsForOrderDB {
  @Id()
  int id;
  String? serverID;
  String? name;
  String? price;
  String? tax;
  String? discount;
  int num;

  final order = ToOne<OrderDB>();
  ProductsForOrderDB({
    this.id = 0,
    this.serverID,
    this.name,
    this.price,
    this.tax,
    this.discount,
    this.num = 0,
  });
}
