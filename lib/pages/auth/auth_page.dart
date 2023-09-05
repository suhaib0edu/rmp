import 'package:rmp/widgets/index_widgets.dart';

import '../../index_c.dart';
import 'auth_page_ctr.dart';
import 'restaurant_list/start/start_page.dart';

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
              InkWell(
                onTap: ()=>Get.to(()=> const StartPage()),
                child: Icon(
                  Icons.flutter_dash,
                  color: SuhColors.background2,
                  size: 80,
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SuhText(text: 'تسجيل الدخول الي  :',),
                  ),
                  SuhTextButtonFill(
                    title: 'حساب المدير',
                    color: SuhColors.buttonO,
                    width: Get.width / 2,
                    onTap: () => controller.auth(),
                  ),
                  SuhTextButtonFill(
                    title: 'حساب المحاسب',
                    color: SuhColors.buttonO,
                    width: Get.width / 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
