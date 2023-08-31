import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import '../index_c.dart';
import '../widgets/suh_snack_bar.dart';

void suhErrorIN(String name, Object e) {
  if (e.toString().contains('Unique constraint for')) {
    SuhSnackBar.messageElementIsExists();
  }
  debugPrint('###<=error=>### in $name => $e');
}

Future<List<String>?> getDeviceData() async {
  List list = [];
  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      list = [
        "fingerprint: ${androidInfo.fingerprint}",
        "board: ${androidInfo.board}",
        "model: ${androidInfo.model}",
        "hardware: ${androidInfo.hardware}",
      ];
      return ['isAndroid',list.toString()];
    } else{
      if(Platform.isWindows){
         WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
         list = [
           "deviceId: ${windowsInfo.deviceId}",
           "releaseId: ${windowsInfo.releaseId}",
           "productId: ${windowsInfo.productId}",
           "userName: ${windowsInfo.userName}",
           "computerName: ${windowsInfo.computerName}",
         ];
         return ['isWindows',list.toString()];
      }
    }
  } catch (e) {
    suhErrorIN('getDeviceId()', e);
  }
  return null;
}
