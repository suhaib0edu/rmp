
import 'package:rmp/pages/auth/restaurant_list/start/control_panel/subscriptions/subscriptions_ad.dart';

import '../../../../../index_c.dart';
import '../../../../../widgets/w_items/index_w_items.dart';
import 'billing_history/billing_history_ad.dart';
import 'groups/groups_ad.dart';
import 'product/product_ad.dart';

class ControlPanelPage extends StatelessWidget {
  const ControlPanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            const TopTaps(
              title: 'لوحة الإدارة',
            ),
            ContainerTextWithIcon(
              onTap: () => Get.to(() => const ProductAD()),
            ),
            ContainerTextWithIcon(
              title: 'المجموعات',
              onTap: () => Get.to(() => const GroupsAD()),
            ),
            ContainerTextWithIcon(
              title: 'سجل الفواتير',
              onTap: () => Get.to(() => const BillingHistoryAD()),
            ),
            ContainerTextWithIcon(
              title: 'الباقات و الإشتراكات',
              onTap: () => Get.to(() => const SubscriptionsAD()),
            )
          ],
        ),
      ),
    );
  }
}
