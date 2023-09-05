import 'package:rmp/widgets/w_items/index_w_items.dart';
import '../../../../../../index_c.dart';
import '../../../../../../widgets/index_widgets.dart';
import '../order_confirmation/order_confirmation.dart';

class DeliveryInfoPage extends StatelessWidget {
  const DeliveryInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopTaps(
              title: 'بيانات العميل',
            ),
            Expanded(
              child: ListView(
                children: const [
                  SuhTextField(
                    hintText: 'اسم العميل',
                  ),
                  SuhTextField(
                    hintText: 'رقم الجوال',
                    keyboardType: TextInputType.phone,
                  ),
                  SuhTextField(
                    hintText: 'العنوان',
                    minLines: 5,
                    radius: 20,
                  ),

                ],
              ),
            ),
            BottomTaps(
              onTap: () => Get.to(() => const OrderConfirmationPage()),
            ),
          ],
        ),
      ),
    );
  }
}
