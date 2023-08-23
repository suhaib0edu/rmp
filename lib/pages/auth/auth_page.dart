import 'package:rmp/widgets/index_widgets.dart';

import '../../index_c.dart';
import 'auth_page_ctr.dart';

class AuthPage extends GetView<AuthPageCTR> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthPageCTR());
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.flutter_dash,
                color: SuhColors.background2,
                size: 80,
              ),
              SuhTextButtonFill(
                title: 'تسجيل',
                color: SuhColors.buttonO,
                width: Get.width / 2,
                onTap: () => controller.auth(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
