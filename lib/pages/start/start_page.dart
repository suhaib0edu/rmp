import 'package:permission_handler/permission_handler.dart';
import 'package:rmp/pages/start/start_page_ctr.dart';
import 'package:rmp/pages/select_order/select_order_page.dart';

import '../../index_c.dart';
import '../../widgets/index_widgets.dart';
import '../control_panel/control_panel.dart';

class StartPage extends GetView<StartPageCTR> {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StartPageCTR());

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SuhTextButtonFill(
                  title: 'طلب جديد',
                  color: SuhColors.buttonO,
                  width: Get.width / 1.8,
                  onTap: () => Get.to(() => const SelectOrderPage()),
                ),
                const SizedBox(
                  height: 6,
                ),
                SuhTextButtonFill(
                  title: 'لوحة التحكم',
                  color: SuhColors.buttonO,
                  width: Get.width / 1.8,
                  onTap: () => Get.to(() => const ControlPanelPage()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
