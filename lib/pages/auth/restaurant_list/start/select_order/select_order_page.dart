import '../../../../../index_c.dart';
import '../../../../../widgets/index_widgets.dart';
import '../../../../../widgets/w_items/index_w_items.dart';
import 'delivery_info/delivery_info_page.dart';
import 'order_confirmation/order_confirmation.dart';
import 'select_order_page_ctr.dart';

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
                builder: (ctr) => WContainer(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => ctr.localOrder(),
                        child: Row(
                          children: [
                            SuhSelect(
                              isSelected: !ctr.isDelivery,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const SuhText(text: 'محلي'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => ctr.deliveryOrder(),
                        child: Row(
                          children: [
                            SuhSelect(
                              isSelected: ctr.isDelivery,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const SuhText(text: 'توصيل'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///ListOrder
              GetBuilder<SelectOrderPageCTR>(
                id: 'getCategoryWithProducts',
                builder: (ctr) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ctr.categoryList.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListOrderContainer(
                        onTap: () => ctr.listVisible(index: index),
                        text: ctr.categoryList[index].name,
                      ),
                      Visibility(
                        visible: ctr.categoryList[index].isVisible,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ctr.categoryList[index].products.length,
                          itemBuilder: (context, index2) =>
                              ItemListOrderContainer(
                            onSelectTap: () =>
                                ctr.onSelectOrder(index: index, index2: index2),
                            isSelected: ctr
                                .categoryList[index].products[index2].isSelect,
                            title:
                                ctr.categoryList[index].products[index2].name,
                            onTapE: () =>
                                ctr.productAdd(index: index, index2: index2),
                            onTapD: () =>
                                ctr.productDel(index: index, index2: index2),
                            hintText: ctr
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
                        Get.to(() => const DeliveryInfoPage());
                        controller.getProductsList();
                      } else {
                        Get.to(() => const OrderConfirmationPage());
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
                          padding: const EdgeInsets.all(8),
                          width: Get.width / 2.0,
                          height: 50,
                          color: SuhColors.background,
                          radius: 30,
                          child: Align(
                            alignment: Alignment.center,
                            child: GetBuilder<SelectOrderPageCTR>(
                              id: 'getTotal',
                              builder: (ctr) => SuhText(
                                text: ctr.total,
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
