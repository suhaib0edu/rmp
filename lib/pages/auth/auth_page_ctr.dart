import 'package:google_sign_in/google_sign_in.dart';
import 'package:rmp/services/server/graphql/graphql.dart';
import 'package:rmp/services/utils.dart';
import '../../index_c.dart';

class AuthPageCTR extends GetxController {
  auth() async {
    try {
      // GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // getIpAddress();
      getDeviceId();

      //
      // CreateUserMutation.send(email: googleUser!.email,
      //     firstName: googleUser.displayName!.split(' ').first,
      //     googleId: googleUser.id,
      //     lastName: googleUser.displayName!.split(' ').last,
      //     ipAddress: ipAddress,
      //     deviceId: deviceId);
      //
    } catch (e) {
      debugPrint('$e');
    }
  }
}

class CreateUserMutation {
  static send({

    required String email,
    required String firstName,
    required String googleId,
    required String lastName,
    required String ipAddress,
    required String deviceId,
  }) async {
    await GQL.mutation(document:
    '''
mutation MyMutation {
  createUser(
    email: $email 
    firstName: $firstName
    googleId: $googleId
    lastName: $lastName
    ipAddress: $ipAddress 
    deviceId: $deviceId
  ) {
    success
    user {
      id
      username
      email
      firstName
      lastName
    }
  }
}
    '''
      ,);
  }
}