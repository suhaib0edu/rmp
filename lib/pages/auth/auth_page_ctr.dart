import 'package:google_sign_in/google_sign_in.dart';
import 'package:rmp/services/utils.dart';
import 'package:rmp/widgets/suh_snack_bar.dart';
import '../../index_c.dart';
import '../../models/models.dart';
import 'restaurant_list/restaurant_list.dart';

class AuthPageCTR extends GetxController {
  int checkStateLogin = 0; //0=checking,1=login,2=not

  @override
  void onInit() {
    checkUserLogin();
    super.onInit();
  }

  auth() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      List<String>? device = await getDeviceData();
      if (device != null) {
        if (!await loginUser(
          device: device,
          email: googleUser?.email,
          googleId: googleUser?.id,
        )) {
          await createUser(
            googleUser: googleUser!,
            device: device,
          );
        }
      } else {
        SuhSnackBar.warningSnackBar(message: 'يبدو ان جهازك لا يدعم الخدمة');
        suhErrorIN('AuthPageCTR=>auth()',
            'جهاز لا يدعم الخدمة - ${googleUser?.email} ');
      }
    } catch (e) {
      suhErrorIN('AuthPageCTR=>auth()', e);
    }
  }

  Future<bool> createUser({
    required GoogleSignInAccount googleUser,
    required List<String> device,
  }) async {
    try {
      ModelMutation modelMutation = await CreateUserMutation.send(
        email: googleUser.email,
        firstName: googleUser.displayName!.split(' ').first,
        googleId: googleUser.id,
        lastName: googleUser.displayName!.split(' ').last,
        deviceType: device[0],
        deviceDetails: device[1],
      );
      if (modelMutation.success == true) {
        try {
          var user = modelMutation.user;
          setLogin(user: user);
        } finally {
          Get.to(() => const RestaurantListPage());
        }
        return true;
      }
    } catch (e) {
      suhErrorIN('AuthPageCTR=>createUser()', e);
    }
    return false;
  }

  Future<bool> loginUser({
    String? email,
    String? googleId,
    String? username,
    String? password,
    required List<String> device,
  }) async {
    try {
      ModelMutation modelMutation = await LoginUserMutation.send(
        email: email,
        googleId: googleId,
        username: username,
        password: password,
        deviceType: device[0],
        deviceDetails: device[1],
      );
      if (modelMutation.success == true) {
        try {
          var user = modelMutation.user;
          setLogin(user: user);
          if (user != null && user.restaurant != null) {
            UserSL().addRestaurant(
                listRestaurant: user.restaurant ?? <Restaurant>[],fromServer: true);
          }
        } finally {
          Get.to(() => const RestaurantListPage());
        }
        return true;
      }
    } catch (e) {
      suhErrorIN('AuthPageCTR=>loginUser()', e);
    }
    return false;
  }

  Future<void> checkUserLogin() async {
    checkStateLogin = configDB.getAll().first.isLogin ? 1 : 2;
    await Future.delayed(const Duration(seconds: 3), () => update());
    if (checkStateLogin == 1) {
      Get.off(() => const RestaurantListPage());
      checkStateLogin = 2;
    }
  }

  void setLogin({User? user}) {
    try {
      UserSL().toDB(user: user);
      ConfigDB().setIsLogin();
    } catch (e) {
      suhErrorIN('setLogin()', e);
    }
  }
}

class CreateUserMutation {
  static send({
    required String email,
    required String firstName,
    required String googleId,
    required String lastName,
    required String deviceType,
    required String deviceDetails,
  }) async {
    var x = ModelMutation.fromJson(
      await GQL.mutation(
        nMutation: 'createUser',
        docVariables: '''
deviceDetails: String!
deviceType: String!
email: String!
firstName: String!
googleId: String!
lastName: String!
      ''',
        mResponse: '''
    success
    error
    token
    user {
      username
      email
      phone
      roles
      firstName
      lastName
      security {
        id
        deviceType
        deviceDetails
      }
    }
      ''',
        variables: {
          'email': email,
          'firstName': firstName,
          'googleId': googleId,
          'lastName': lastName,
          'deviceType': deviceType,
          'deviceDetails': deviceDetails,
        },
        withToken: false,
      ),
    );
    return x;
  }
}

class LoginUserMutation {
  static send({
    String? email,
    String? googleId,
    String? username,
    String? password,
    required String deviceType,
    required String deviceDetails,
  }) async {
    return ModelMutation.fromJson(
      await GQL.mutation(
        nMutation: 'loginUser',
        docVariables: '''
deviceDetails: String!
deviceType: String!
email: String
googleId: String
password: String
username: String
      ''',
        mResponse: '''
    success
    error
    token
    user {
      username
      email
      phone
      firstName
      lastName
      roles
      security {
        id
        deviceType
        deviceDetails
      }
      restaurant {
        id
        phone
        restaurantName
        Category {
          id
          name
          Products {
            id
            name
            price
            tax
            discount
          }
        }
        address {
          id
          country
          state
          city
          neighborhood
        }
        cahir {
          username
          roles
          firstName
          lastName
        }
        orders {
          id
          orderDate
          orderType
          accountant {
            username
            roles
          }
          products {
            id
            name
            price
            tax
            discount
          }
        }
        subscriptions {
          id
          subscriptionDate
          expiryDate
        }
      }
    }
      ''',
        variables: {
          'email': email,
          'googleId': googleId,
          'password': password,
          'username': username,
          'deviceType': deviceType,
          'deviceDetails': deviceDetails,
        },
        withToken: false,
      ),
    );
  }
}
