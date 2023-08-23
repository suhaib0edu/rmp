import 'package:rmp/pages/select_order/select_order_page_ctr.dart';
import 'package:rmp/widgets/index_widgets.dart';
import 'package:rmp/widgets/w_items/index_w_items.dart';
import '../../index_c.dart';
import '../delivery_info/delivery_info_page.dart';
import '../order_confirmation/order_confirmation.dart';

class SelectOrderPage extends GetView<SelectOrderPageCTR> {
  const SelectOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SelectOrderPageCTR());
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(
                height: 20,
              ),

              ///isDelivery
              GetBuilder<SelectOrderPageCTR>(
                id: 'isDeliveryID',
                builder: (context) => WContainer(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SuhSelect(
                        isSelected: !controller.isDelivery,
                        onTap: () => controller.localOrder(),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const SuhText(text: 'محلي'),
                      const SizedBox(
                        width: 10,
                      ),
                      SuhSelect(
                        isSelected: controller.isDelivery,
                        onTap: () => controller.deliveryOrder(),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const SuhText(text: 'توصيل'),
                    ],
                  ),
                ),
              ),

              ///ListOrder
              GetBuilder<SelectOrderPageCTR>(
                id: 'getCategoryWithProducts',
                builder: (context) => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListOrderContainer(
                        onTap: () => controller.listVisible(index: index),
                        text: controller.categoryList[index].name,
                      ),
                      Visibility(
                        visible: controller.categoryList[index].isVisible,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              controller.categoryList[index].products.length,
                          itemBuilder: (context, index2) =>
                              ItemListOrderContainer(
                            onSelectTap: () => controller.onSelectOrder(
                                index: index, index2: index2),
                            isSelected: controller
                                .categoryList[index].products[index2].isSelect,
                            title: controller
                                .categoryList[index].products[index2].name,
                            onTapE: () => controller.productAdd(
                                index: index, index2: index2),
                            onTapD: () => controller.productDel(
                                index: index, index2: index2),
                            hintText: controller
                                .categoryList[index].products[index2].num
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 80,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                const SizedBox(
                  height: 105,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomTaps(
                    height: 80,
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
                    onTap: () {
                      if (controller.isDelivery) {
                        Get.to(() => DeliveryInfoPage());
                      } else {
                        Get.to(() => OrderConfirmationPage());
                        controller.getProductsList();
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      SuhContainer(
                        padding: const EdgeInsets.all(2),
                        width: Get.width / 2.0,
                        height: 50,
                        color: SuhColors.text.withOpacity(0.5),
                        radius: 30,
                        child: SuhContainer(
                          padding: EdgeInsets.all(8),
                          width: Get.width / 2.0,
                          height: 50,
                          color: SuhColors.background,
                          radius: 30,
                          child: Align(
                            alignment: Alignment.center,
                            child: GetBuilder<SelectOrderPageCTR>(
                              id: 'getTotal',
                              builder: (context) => SuhText(
                                text: controller.total,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
