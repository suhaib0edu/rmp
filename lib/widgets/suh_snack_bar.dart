import '../index_c.dart';

class SuhSnackBar {

  static messageElementIsExists() =>
      warningSnackBar(message: 'العنصر موجود بالفعل');

  static messageCheckFieldNotEmpty() =>
      warningSnackBar(message: 'تحقق ان جميع الحقول مدخلة بشكل صحيح');

  static messageSelectElement() =>
      warningSnackBar(message: 'حدد عنصر');

  static warningSnackBar({
    required String message,
  }) {
    Get.snackbar(
      'إنتباه',
      message,
      colorText: SuhColors.text,
      backgroundColor: Colors.redAccent.withOpacity(0.5),
    );
  }
}
