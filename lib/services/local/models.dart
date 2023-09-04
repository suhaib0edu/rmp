import 'package:flutter/cupertino.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ConfigDB {
  @Id()
  int id;
  String? token;
  String? username;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? roles;
  DateTime? exSubscriptions;
  bool? isSubscription;
  bool? isSubscriptionWindows;
  bool? isSubscriptionPhone;

  // bool? appHasNewUpdate;

  ConfigDB({
    this.id = 0,
    this.token,
    this.username,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.roles,
    this.exSubscriptions,
    this.isSubscription = false,
    this.isSubscriptionWindows = false,
    this.isSubscriptionPhone = false,
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
  ConfigDB? owner;
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

// Save Local

@Entity()
class UserSL {
  @Id()
  int id = 0;
  bool isUpload;
  @Unique()
  String? username;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? roles;
  final security = ToMany<SecuritySL>();
  final restaurant = ToMany<RestaurantSL>();

  UserSL({
    this.username,
    this.isUpload = false,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.roles,
  });
}

@Entity()
class SecuritySL {
  @Id()
  int id = 0;
  @Unique()
  String? serverID;
  bool isUpload;
  String? deviceDetails;
  String? deviceType;

  SecuritySL({
    this.serverID,
    this.isUpload = false,
    this.deviceDetails,
    this.deviceType,
  });
}

@Entity()
class RestaurantSL {
  @Id()
  int id = 0;
  @Unique()
  String? serverID;
  bool isUpload;
  @Unique()
  String? name;
  AddressSL? address;
  final category = ToMany<CategorySL>();
  final orders = ToMany<OrdersSL>();
  final products = ToMany<ProductsSL>();
  final subscriptions = ToMany<SubscriptionsSL>();

  RestaurantSL({
    this.serverID,
    this.isUpload = false,
    this.name,
    this.address,
  });
}

@Entity()
class AddressSL {
  @Id()
  int id = 0;
  @Unique()
  String? serverID;
  bool isUpload;
  String? country;
  String? state;
  String? city;
  String? neighborhood;

  AddressSL({
    this.serverID,
    this.isUpload = false,
    this.country,
    this.state,
    this.city,
    this.neighborhood,
  });
}

@Entity()
class CategorySL {
  @Id()
  int id = 0;
  @Unique()
  String? serverID;
  bool isUpload;
  @Unique()
  String? name;
  List<ProductsSL>? products;

  CategorySL({this.serverID, this.isUpload = false, this.name, this.products});
}

@Entity()
class ProductsSL {
  @Id()
  int id = 0;
  @Unique()
  String? serverID;
  bool isUpload;
  @Unique()
  String? name;
  String? price;
  String? tax;
  String? discount;

  ProductsSL({
    this.serverID,
    this.isUpload = false,
    this.name,
    this.price,
    this.tax,
    this.discount,
  });
}

@Entity()
class OrdersSL {
  @Id()
  int id = 0;
  @Unique()
  String? serverID;
  bool isUpload;
  UserSL? accountant;
  String? orderType;
  String? orderDate;
  final products = ToMany<ProductsSL>();

  OrdersSL({
    this.serverID,
    this.isUpload = false,
    this.accountant,
    this.orderType,
    this.orderDate,
  });
}

@Entity()
class SubscriptionsSL {
  @Id()
  int id = 0;
  bool isUpload;
  @Unique()
  String? serverID;
  String? edition;
  String? subscriptionDate;
  String? expiryDate;

  SubscriptionsSL({
    this.serverID,
    this.isUpload = false,
    this.edition,
    this.subscriptionDate,
    this.expiryDate,
  });
}
