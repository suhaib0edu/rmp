import 'package:rmp/widgets/index_widgets.dart';
import 'package:rmp/widgets/w_items/index_w_items.dart';
import '../../../../../../index_c.dart';

class SubscriptionsAD extends StatelessWidget {
  const SubscriptionsAD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            const TopTaps(
              title: 'الباقات و الاشتراكات',
            ),
            SubscriptionsContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        SuhText(text: 'تاريخ الاشتراك: 25/07/2023',fontSize: 12,),
                        SuhText(text: 'تاريخ الإنتهاء: 25/07/2023',fontSize: 12,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SuhText(text: 'رصيدك الحالي: 35.000ج',fontSize: 12,),
                        SuhContainer(
                          radius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                          color: SuhColors.text.withOpacity(0.4),
                          child: const SuhText(text: 'شحن الرصيد',fontSize: 12,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PackagesContainer(
              color: SuhColors.text.withOpacity(0.3),
            ),
            PackagesContainer(
              title: 'الباقة الذهبية',
              color: Colors.orange.withOpacity(0.8),
              day: '180',
            ),
            PackagesContainer(
              title: 'الباقة الماسية',
              color: SuhColors.buttonO.withOpacity(0.8),
              day: '360',
            ),
          ],
        ),
      ),
    );
  }
}
