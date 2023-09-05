import '../../../../../../index_c.dart';
import '../../../../../../widgets/index_widgets.dart';
import '../../../../../../widgets/w_items/index_w_items.dart';
import 'billing_history_ad_ctr.dart';

class BillingHistoryAD extends GetView<BillingHistoryADCTR> {
  const BillingHistoryAD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BillingHistoryADCTR());
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            const TopTaps(
              title: 'سجل الفواتير',
            ),
            ContainerTextWithIcon(
              title: 'تقرير اليوم',
              onTap: () {
                try {
                  controller.getInvoicesForToday();
                } finally {
                  bottomSheet();
                }
              },
            ),
            ContainerTextWithIcon(
              title: 'تقرير الشهر',
              onTap: () {
                try {
                  controller.getInvoicesForMonth();
                } finally {
                  bottomSheet();
                }
              },
            ),
            ContainerTextWithIcon(
              title: 'تقرير العام',
              onTap: () {
                try {
                  controller.getInvoicesForYear();
                } finally {
                  bottomSheet();
                }
              },
            ),

          ],
        ),
      ),
    );
  }

  void bottomSheet() {
    Get.bottomSheet(
      SuhContainer(
        color: SuhColors.background,
        child: ListView(
          children: [
            const SizedBox(
              height: 26,
            ),
            const TopTaps(
              title: 'التقرير الشامل',
            ),
            ComprehensiveInvoice(
              invoiceFormat: 3,
              listProduct: controller.listOrderV,
              dateTime: controller.dateTime,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
