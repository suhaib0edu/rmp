import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class StartPageCTR extends GetxController{
  final PermissionStatus _initialStatus = PermissionStatus.denied;
  final Rx<PermissionStatus> _permissionStatus = PermissionStatus.denied.obs;

  PermissionStatus get permissionStatus => _permissionStatus.value;


  @override
  void onInit() {
    _checkPermissionStatus();
    super.onInit();
  }

  void _checkPermissionStatus() async {
    try {
      final status = await Permission.storage.status;
      _permissionStatus.value = status;
      if (status.isDenied) {
        requestPermission();
      } else {
        print(status);
      }
    }catch(e){
      print(e);
    }
  }

  void requestPermission() async {
    final status = await Permission.storage.request();
    _permissionStatus.value = status;
  }
}