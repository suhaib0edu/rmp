import 'package:rmp/widgets/w_items/index_w_items.dart';

import '../../../index_c.dart';

class BillingHistoryAD extends StatelessWidget {
  const BillingHistoryAD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            TopTaps(
              title: 'سجل الفواتير',
            ),
            ContainerTextWithIcon(
              title: 'تقرير اليوم',
            ),
            ContainerTextWithIcon(
              title: 'تقرير الشهر',
            ),
            ContainerTextWithIcon(
              title: 'تقرير العام',
            ),

          ],
        ),
      ),
    );
  }
}
