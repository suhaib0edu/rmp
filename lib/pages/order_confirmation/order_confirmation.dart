import 'package:rmp/pages/order_confirmation/order_confirmation_ctr.dart';

import '../../index_c.dart';
import '../../widgets/index_widgets.dart';
import '../../widgets/w_items/index_w_items.dart';
import '../select_order/select_order_page_ctr.dart';

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
                          onTap: () => controller.printOrder(),
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
      return Column(
        children: [
          ...ctr.listProduct
              .map((e) => invoiceFormBase(
                      invoiceFormat: ctr.invoiceFormat,
                      child: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            cTable(
                                flex: 2,
                                text: e.name.toString(),
                                alignment: Alignment.centerRight),
                            cTable(text: e.num.toString()),
                            cTable(text: e.price.toString()),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 8),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: SuhText(
                                  text:
                                      ' اجمالي : ${e.num * int.parse(e.price!)} جنيه')),
                        ),
                      ]))
              .toList(),
        ],
      );
    } else if (ctr.invoiceFormat == 1) {
      return Column(
        children: [
          ...ctr.categoryList.map((lCat) {
            bool cat = false;
            int total = 0;
            lCat.products.map((element) {
              if (element.isSelect) {
                cat = true;
              }
            }).toList();
            if (cat) {
              return invoiceFormBase(
                  invoiceFormat: ctr.invoiceFormat,
                  child: [
                    ...lCat.products.map((e) {
                      total = total + e.num * int.parse(e.price!);
                      if (e.isSelect) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                cTable(
                                    flex: 2,
                                    text: e.name.toString(),
                                    alignment: Alignment.centerRight),
                                cTable(
                                  text: e.num.toString(),
                                ),
                                cTable(
                                  text: e.price.toString(),
                                ),
                                cTable(text: '${e.num * int.parse(e.price!)}'),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }).toList(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: SuhText(text: ' اجمالي : $total جنيه')),
                    ),
                  ]);
            } else {
              return const SizedBox();
            }
          }).toList()
        ],
      );
    } else {
      int total = 0;
      return Column(
        children: [
          invoiceFormBase(invoiceFormat: ctr.invoiceFormat, child: [
            ...ctr.listProduct.map((e) {
              total = total + e.num * int.parse(e.price!);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      cTable(
                          flex: 2,
                          text: e.name.toString(),
                          alignment: Alignment.centerRight),
                      cTable(text: e.num.toString()),
                      cTable(text: e.price.toString()),
                      cTable(text: '${e.num * int.parse(e.price ?? '0')}'),
                    ],
                  ),
                ],
              );
            }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: SuhText(text: ' المجموع الكلي : $total  جنيه')),
            ),
          ]),
        ],
      );
    }
  }

  Widget textInvoice(String t) {
    return Row(
      children: [
        SuhText(text: t),
      ],
    );
  }

  Widget topTable(int invoiceFormat) {
    return Row(
      children: [
        cTable(
          flex: 2,
          text: 'المنتج',
          alignment: Alignment.centerRight,
        ),
        cTable(
          text: 'العدد',
        ),
        cTable(
          text: 'السعر',
        ),
        if (invoiceFormat > 0) cTable(text: 'اجمالي'),
      ],
    );
  }

  Widget cTable(
      {AlignmentGeometry alignment = Alignment.center,
      int flex = 1,
      required String text}) {
    return Expanded(
        flex: flex,
        child: Align(
            alignment: alignment,
            child: flex > 1
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SuhText(text: text),
                  )
                : SuhText(text: text)));
  }

  Widget invoiceFormBase(
      {required int invoiceFormat, required List<Widget> child}) {
    return SuhContainer(
      color: SuhColors.container,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      radius: 10,
      child: Column(
        children: [
          textInvoice('الكاشير : محمد'),
          textInvoice('التاريخ : ${DateTime.now()}'),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: SuhColors.text,
            height: 8,
            indent: 18,
            endIndent: 18,
          ),
          topTable(invoiceFormat),
          Divider(
            color: SuhColors.text,
            height: 8,
            indent: 18,
            endIndent: 18,
          ),
          ...child
        ],
      ),
    );
  }
}
