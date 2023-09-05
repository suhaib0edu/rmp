class ModelMutation {
  bool? success;
  String? error;
  String? token;
  User? user;

  ModelMutation({this.success, this.error, this.token, this.user});

  ModelMutation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? username;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? roles;
  List<Security>? security;
  List<Restaurant>? restaurant;

  User({
    this.username,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.roles,
    this.security,
    this.restaurant,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    roles = json['roles'];
    if (json['security'] != null) {
      security = [];
      json['security'].forEach((v) {
        security!.add(Security.fromJson(v));
      });
    }
    if (json['restaurant'] != null) {
      restaurant = [];
      json['restaurant'].forEach((v) {
        restaurant?.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['roles'] = roles;
    if (security != null) {
      data['security'] = security!.map((v) => v.toJson()).toList();
    }
    if (restaurant != null) {
      data['restaurant'] = restaurant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Security {
  String? id;
  String? deviceDetails;
  String? deviceType;

  Security({this.id, this.deviceDetails, this.deviceType});

  Security.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceDetails = json['deviceDetails'];
    deviceType = json['deviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceDetails'] = deviceDetails;
    data['deviceType'] = deviceType;
    return data;
  }
}

class Restaurant {
  String? id;
  Address? address;
  List<Category>? category;
  List<Orders>? orders;
  List<Products>? products;
  List<Subscriptions>? subscriptions;

  Restaurant(
      {this.id,
        this.address,
        this.category,
        this.orders,
        this.products,
        this.subscriptions});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['Category'] != null) {
      category = <Category>[];
      json['Category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (category != null) {
      data['Category'] = category!.map((v) => v.toJson()).toList();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (subscriptions != null) {
      data['subscriptions'] =
          subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? id;
  String? country;
  String? state;
  String? city;
  String? neighborhood;

  Address({this.id, this.country, this.state, this.city, this.neighborhood});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['neighborhood'] = neighborhood;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  List<Products>? products;

  Category({this.id, this.name, this.products});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (products != null) {
      data['Products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? id;
  String? name;
  String? price;
  String? tax;
  String? discount;

  Products({this.id, this.name, this.price, this.tax, this.discount});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    tax = json['tax'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['tax'] = tax;
    data['discount'] = discount;
    return data;
  }
}

class Orders {
  String? id;
  User? accountant;
  String? orderType;
  String? orderDate;
  List<Products>? products;

  Orders(
      {this.id,
        this.accountant,
        this.orderType,
        this.orderDate,
        this.products});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountant = json['accountant'] != null
        ? User.fromJson(json['accountant'])
        : null;
    orderType = json['orderType'];
    orderDate = json['orderDate'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (accountant != null) {
      data['accountant'] = accountant!.toJson();
    }
    data['orderType'] = orderType;
    data['orderDate'] = orderDate;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscriptions {
  String? id;
  String? edition;
  String? subscriptionDate;
  String? expiryDate;

  Subscriptions(
      {this.id, this.edition, this.subscriptionDate, this.expiryDate});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    edition = json['edition'];
    subscriptionDate = json['subscriptionDate'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['edition'] = edition;
    data['subscriptionDate'] = subscriptionDate;
    data['expiryDate'] = expiryDate;
    return data;
  }
}