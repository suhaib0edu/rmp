import 'package:rmp/widgets/index_widgets.dart';

import '../../index_c.dart';
import '../../services/local/models.dart';

// 1
class InvoicePerProduct extends StatelessWidget {
  final List<ProductsSL> listProduct;
  final int invoiceFormat;

  const InvoicePerProduct(
      {Key? key, required this.listProduct, required this.invoiceFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...listProduct
            .map((e) =>
                BasicInvoiceTemplate(dateTime: DateTime.now(),invoiceFormat: invoiceFormat, child: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CTable(
                          flex: 2,
                          text: e.name.toString(),
                          alignment: Alignment.centerRight),
                      CTable(text: e.num.toString()),
                      CTable(text: e.price.toString()),
                      CTable(text: '${int.parse(e.discount ?? '0') * e.num}'),
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
  }
}

// 2
class InvoicePerGroup extends StatelessWidget {
  final List<CategorySL> categoryList;
  final int invoiceFormat;

  const InvoicePerGroup(
      {Key? key, required this.categoryList, required this.invoiceFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...categoryList.map((lCat) {
          bool cat = false;
          int total = 0;
          lCat.products.map((element) {
            if (element.isSelect) {
              cat = true;
            }
          }).toList();
          if (cat) {
            return BasicInvoiceTemplate(dateTime: DateTime.now(),invoiceFormat: invoiceFormat, child: [
              ...lCat.products.map((e) {
                total = total + e.num * int.parse(e.price!);
                if (e.isSelect) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          CTable(
                              flex: 2,
                              text: e.name.toString(),
                              alignment: Alignment.centerRight),
                          CTable(
                            text: e.num.toString(),
                          ),
                          CTable(
                            text: e.price.toString(),
                          ),
                          CTable(text: '${int.parse(e.discount ?? '0') * e.num}'),
                          CTable(text: '${e.num * int.parse(e.price!)}'),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }).toList(),
              Divider(
                color: SuhColors.text,
                height: 8,
                indent: 18,
                endIndent: 18,
              ),
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
  }
}

// 3
class ComprehensiveInvoice extends StatelessWidget {
  final int invoiceFormat;
  final List<ProductsSL> listProduct;
  final DateTime dateTime;

  const ComprehensiveInvoice(
      {Key? key, required this.invoiceFormat, required this.listProduct, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = 0;
    int totalTax = 0;
    int totalDiscount = 0;
    return Column(
      children: [
        BasicInvoiceTemplate(dateTime: dateTime,invoiceFormat: invoiceFormat, child: [
          ...listProduct.map((e) {
            total = total + e.num * int.parse(e.price ?? '0');
            totalTax = totalTax + e.num * int.parse(e.tax ?? '0');
            totalDiscount =
                totalDiscount + e.num * int.parse(e.discount ?? '0');
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CTable(
                        flex: 2,
                        text: e.name.toString(),
                        alignment: Alignment.centerRight),
                    CTable(text: e.num.toString()),
                    if (invoiceFormat != 3) CTable(text: e.price.toString()),
                    if (invoiceFormat == 3)
                      CTable(text: '${int.parse(e.tax ?? '0') * e.num}'),
                      CTable(text: '${int.parse(e.discount ?? '0') * e.num}'),
                    CTable(text: '${e.num * int.parse(e.price ?? '0')}'),
                  ],
                ),
              ],
            );
          }),
          Divider(
            color: SuhColors.text,
            height: 8,
            indent: 18,
            endIndent: 18,
          ),
          if (invoiceFormat == 3)
            SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (invoiceFormat == 3)
                      SuhText(text: ' اجمالي الخصم : $totalDiscount  جنيه'),
                    if (invoiceFormat == 3)
                      SuhText(text: ' اجمالي التحصيل : $totalTax  جنيه'),
                    SuhText(text: ' المجموع الكلي : $total  جنيه'),
                  ],
                )),
          ),
        ]),
      ],
    );
  }
}

class BasicInvoiceTemplate extends StatelessWidget {
  final List<Widget> child;
  final int invoiceFormat;
  final String cashier;
  final DateTime dateTime;

  const BasicInvoiceTemplate(
      {Key? key, required this.child, required this.invoiceFormat, this.cashier = 'المحاسب', required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuhContainer(
      color: SuhColors.container,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      radius: 10,
      child: Column(
        children: [
          if (invoiceFormat != 3)
          TextInvoice(
            t: 'المحاسب : $cashier',
          ),
          TextInvoice(
            t: 'البيانات منذ : $dateTime',
          ),
          TextInvoice(
            t: 'تاريخ اللحظة : ${DateTime.now()}',
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: SuhColors.text,
            height: 8,
            indent: 18,
            endIndent: 18,
          ),
          TopTable(
            invoiceFormat: invoiceFormat,
          ),
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

class TopTable extends StatelessWidget {
  final int invoiceFormat;

  const TopTable({Key? key, required this.invoiceFormat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CTable(
          flex: 2,
          text: 'المنتج',
          alignment: Alignment.centerRight,
        ),
        const CTable(text: 'العدد'),
        if (invoiceFormat != 3) const CTable(text: 'السعر'),
        if (invoiceFormat == 3) const CTable(text: 'التحصيل'),
        const CTable(text: 'الخصم'),
        if (invoiceFormat > 0) const CTable(text: 'اجمالي'),
      ],
    );
  }
}

///

class CTable extends StatelessWidget {
  final int flex;
  final AlignmentGeometry alignment;
  final String text;

  const CTable(
      {Key? key,
      this.flex = 1,
      this.alignment = Alignment.center,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class TextInvoice extends StatelessWidget {
  final String t;

  const TextInvoice({Key? key, required this.t}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SuhText(text: t),
      ],
    );
  }
}
