import 'package:rmp/widgets/index_widgets.dart';
import 'package:rmp/widgets/w_items/index_w_items.dart';

import '../../index_c.dart';
import 'restaurant_list_ctr.dart';

class RestaurantListPage extends GetView<RestaurantListPageCTR> {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RestaurantListPageCTR());
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: GetBuilder<RestaurantListPageCTR>(
        id: 'getRestaurantList',
        builder: (ctr) => Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const SuhText(
              text: 'سلسلة الفروع التي تديرها',
              fontWeight: FontWeight.bold,
            ),
            Expanded(
              child:ListView.builder(
                itemCount: ctr.restaurantList.length+5,
                itemBuilder: (context, index) => restaurantItems(''),
              ),
            ),
            const SizedBox(height: 8,),
            SuhTextButtonFill(
              title: 'تسجيل',
              color: SuhColors.buttonO,
              width: 140,
            ),
            SuhTextButtonFill(
              title: '0000',
              color: SuhColors.buttonO,
              width: 140,
              onTap: ()=> controller.getRestaurantList(),
            ),
            SuhTextButtonFill(
              title: 'إضافة مطعم',
              color: SuhColors.buttonO,
              width: 180,
              onTap: () => Get.bottomSheet(
                const AddNewRestaurant(),
                isScrollControlled: true,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  restaurantItems(String s) {
    return  SuhContainer(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(8),
      color: SuhColors.container,
      radius: 10,
      child:  Row(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: SuhSelect(),
          ),
          SuhText(text: 'القضارف'),
        ],
      ),
    );
  }
}

class AddNewRestaurant extends GetView<RestaurantListPageCTR> {
  const AddNewRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RestaurantListPageCTR());
    return SuhContainer(
      margin: const EdgeInsets.only(top: 100),
      color: SuhColors.background,
      child: ListView(
        children: [
          const TopTaps(
            title: 'إضافة مطعم جديد',
          ),
          SuhTextField(
            hintText: 'اسم المطعم',
            controller: controller.restaurantName,
          ),
          SuhTextField(
            hintText: 'رقم جوال (يجب ان يحتوي على واتساب)',
            controller: controller.phone,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SuhText(text: 'عنوان المطعم'),
                Expanded(
                    child: Divider(
                  endIndent: 10,
                  indent: 10,
                  color: SuhColors.text,
                )),
              ],
            ),
          ),
          SuhTextField(
            hintText: 'الولاية',
            controller: controller.state,
          ),
          SuhTextField(
            hintText: 'المدينة',
            controller: controller.city,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SuhTextButtonFill(
              title: 'أكمل',
              color: SuhColors.buttonG,
              width: Get.width / 1.9,
              onTap: ()=> controller.setRestaurant(),
            ),
          ),
        ],
      ),
    );
  }
}
