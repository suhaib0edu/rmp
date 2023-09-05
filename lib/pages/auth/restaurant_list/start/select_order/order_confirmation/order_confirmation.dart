import '../../../../../../index_c.dart';
import '../../../../../../widgets/index_widgets.dart';
import '../../../../../../widgets/w_items/index_w_items.dart';
import '../select_order_page_ctr.dart';
import 'order_confirmation_ctr.dart';

class OrderConfirmationPage extends GetView<OrderConfirmationPageCTR> {
  const OrderConfirmationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderConfirmationPageCTR());

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(
                height: 20,
              ),

              ///invoice format
              WContainer(
                height: 60,
                child: GetBuilder<SelectOrderPageCTR>(
                    id: 'selectFormat',
                    builder: (ctr) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            invoiceFormSelectView(
                              text: 'فاتورة لكل منتج',
                              isSelected: ctr.invoiceFormat == 0,
                              onTap: () => ctr.selectFormat(0),
                            ),
                            invoiceFormSelectView(
                              text: 'فاتورة لكل مجموعة',
                              isSelected: ctr.invoiceFormat == 1,
                              onTap: () => ctr.selectFormat(1),
                            ),
                            invoiceFormSelectView(
                              text: 'فاتورة شاملة',
                              isSelected: ctr.invoiceFormat == 2,
                              onTap: () => ctr.selectFormat(2),
                            ),
                          ],
                        )),
              ),

              ///ListOrder
              GetBuilder<SelectOrderPageCTR>(
                id: 'getProductsList',
                builder: (selectOrderPageCTR) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectOrderPageCTR.listProduct.length,
                  itemBuilder: (context, index) => ItemListOrderContainer(
                    title: selectOrderPageCTR.listProduct[index].name,
                    hintText:
                        selectOrderPageCTR.listProduct[index].num.toString(),
                    isSelected: selectOrderPageCTR.listProduct[index].isSelect,
                    onTapE: () =>
                        selectOrderPageCTR.addOrderInProList(index: index),
                    onTapD: () =>
                        selectOrderPageCTR.delOrderInProList(index: index),
                  ),
                ),
              ),

              ///invoice format view
              GetBuilder<SelectOrderPageCTR>(
                id: 'selectFormat',
                builder: (ctr) => invoiceFormatView(ctr),
              ),

              const SizedBox(
                height: 120,
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
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 15),
                          titleButton: 'طباعة',
                          onTap: () => controller.setOrder(),
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
                                    builder: (selectOrderPageCTR) => SuhText(
                                      text: selectOrderPageCTR.total,
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
          ),
        ],
      ),
    );
  }

  Widget invoiceFormSelectView(
      {required String text, bool isSelected = false, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SuhSelect(
            isSelected: isSelected,
          ),
          const SizedBox(
            width: 6,
          ),
          SuhText(
            text: text,
            fontSize: 10,
          ),
        ],
      ),
    );
  }

  Widget invoiceFormatView(SelectOrderPageCTR ctr) {
    controller.listProduct = ctr.listProduct;
    if (ctr.invoiceFormat == 0) {
      return InvoicePerProduct(
        listProduct: ctr.listProduct,
        invoiceFormat: ctr.invoiceFormat,
      );
    } else if (ctr.invoiceFormat == 1) {
      return InvoicePerGroup(
        categoryList: ctr.categoryList,
        invoiceFormat: ctr.invoiceFormat,
      );
    } else {
      return ComprehensiveInvoice(
        listProduct: ctr.listProduct,
        invoiceFormat: ctr.invoiceFormat,
        dateTime: DateTime.now(),
      );
    }
  }

}
