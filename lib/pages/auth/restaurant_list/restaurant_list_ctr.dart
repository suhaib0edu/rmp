import 'package:rmp/index_c.dart';
import 'package:rmp/models/models.dart';

class RestaurantListPageCTR extends GetxController {
  List<Restaurant> restaurantList = [];
  TextEditingController restaurantName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  setRestaurant() async {
    restaurantList = [];
    if (restaurantName.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        state.text.isNotEmpty &&
        city.text.isNotEmpty) {
      ModelMutation modelMutation = await CreateRestaurantMutation().send(
        restaurantName: restaurantName.text,
        state: state.text,
        city: city.text,
        phone: phone.text,
      );
      if (modelMutation.success == true) {
        restaurantList.addAll(modelMutation.user?.restaurant ?? []);
      }
    }else{
    }
  }

  getRestaurantList() {
    restaurantList = [];

    update(['getRestaurantList']);
  }
}

class CreateRestaurantMutation {
  send({
    required String restaurantName,
    required String state,
    required String city,
    required String phone,
  }) async {
    return ModelMutation.fromJson(await GQL.mutation(
        nMutation: 'createRestaurant',
        docVariables: '''
city: String!
phone: String!
restaurantName: String!
state: String!
      ''',
        mResponse: '''
    token
    success
    error
    user {
      username
      email
      phone
      firstName
      lastName
      roles
      restaurant {
        id
        restaurantName
        address {
          id
          country
          state
          city
          neighborhood
        }
      }
    }  
      ''',
        variables: {
          'restaurantName': restaurantName,
          'state': state,
          'city': city,
          'phone': phone,
        }));
  }
}

class GetRestaurantMutation {
  send() async {
    return ModelMutation.fromJson(await GQL.mutation(
        nMutation: 'createRestaurant',
        docVariables: '''

      ''',
        mResponse: '''
    token
    success
    error
    user {
      username
      email
      phone
      firstName
      lastName
      roles
      restaurant {
        id
        restaurantName
        address {
          id
          country
          state
          city
          neighborhood
        }
      }
    }  
      ''',
        variables: {}));
  }
}


