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
  final products = ToMany<ProductsSL>();
  bool isVisible = false;

  CategorySL({this.serverID, this.isUpload = false, this.name,});
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
  int num;
  bool isSelect;

  ProductsSL({
    this.serverID,
    this.isUpload = false,
    this.name,
    this.price,
    this.tax,
    this.discount,
    this.num = 0,
    this.isSelect = false,
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
  DateTime? date;
  @Backlink('order')
  final products = ToMany<ProductsOrderSL>();

  OrdersSL({
    this.serverID,
    this.isUpload = false,
    this.accountant,
    this.orderType,
    this.date,
  });
}

@Entity()
class ProductsOrderSL {
  @Id()
  int id = 0;
  @Unique()
  String? serverID;
  bool isUpload;
  String? name;
  String? price;
  String? tax;
  String? discount;
  int num;
  bool isSelect;
  final order = ToOne<OrdersSL>();

  ProductsOrderSL({
    this.serverID,
    this.isUpload = false,
    this.name,
    this.price,
    this.tax,
    this.discount,
    this.num = 0,
    this.isSelect = false,
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
