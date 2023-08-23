import 'dart:io';
import '../widgets/suh_snack_bar.dart';

void suhErrorIN(String name , Object e) {
  if(e.toString().contains('Unique constraint for')){
    SuhSnackBar.messageElementIsExists();
  }
  print('error in $name => $e');
}
Future<void> getDeviceId() async {
  try {
    print('Platform.isAndroid=> ${Platform.isAndroid}');
    //
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.id}');
  } catch (e) {
    print(e);
  }
}

Future<void> getIpAddress() async {
  final result = await InternetAddress.lookup('google.com');
  final ipAddress = result.first.address;
  print(ipAddress);
  // return ipAddress;
}

//
// Future<void> getDeviceId() async {
//   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   if (Platform.isAndroid) {
//     final AndroidDeviceInfo androidDeviceInfo =
//     await deviceInfoPlugin.androidInfo;
//     print(androidDeviceInfo.androidId);
//   } else if (Platform.isIOS) {
//     final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
//     print(iosDeviceInfo.identifierForVendor);
//   }
// }
