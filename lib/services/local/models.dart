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
  @Backlink('category')
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
  @Unique()
  String? name;
  String? price;
  String? tax;
  String? discount;
  UserDB? owner;
  int num;
  bool isSelect;
  TextEditingController? controller;

  final category = ToOne<ProductsDB>();

  ProductsDB({
    this.id = 0,
    this.serverID,
    this.name,
    this.price,
    this.tax,
    this.discount,
    this.owner,
    this.num = 0,
    this.isSelect = false,
    this.controller
  });
}
