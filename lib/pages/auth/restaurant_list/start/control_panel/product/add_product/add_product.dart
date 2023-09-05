import '../../../../../../../index_c.dart';
import '../../../../../../../widgets/index_widgets.dart';
import '../../../../../../../widgets/w_items/index_w_items.dart';
import 'add_product_ctr.dart';

class AddProductPage extends GetView<AddProductPageCTR> {
  final ProductsSL? editProduct;

  const AddProductPage({Key? key, this.editProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddProductPageCTR());
    controller.editProduct(editProduct: editProduct);
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const TopTaps(
              title: 'إضافة منتج جديد',
            ),
            GetBuilder<AddProductPageCTR>(
              id: 'visibleCategory',
              builder: (context) => Expanded(
                child: ListView(
                  children: [
                    SuhTextField(
                      hintText: 'اسم المنتج',
                      controller: controller.nameController,
                    ),
                    SuhTextField(
                      hintText: 'السعر',
                      controller: controller.priceController,
                      keyboardType: TextInputType.phone,
                    ),
                    SuhTextField(
                      hintText: 'الخصم',
                      controller: controller.discountController,
                      keyboardType: TextInputType.phone,
                    ),
                    SuhTextField(
                      hintText: 'التحصيل',
                      controller: controller.taxController,
                      keyboardType: TextInputType.phone,
                    ),
                    ListOrderContainer(
                      text: controller.selectCategory,
                      onTap: () {
                        controller.visibleCategory =
                            !controller.visibleCategory;
                        controller.update(['visibleCategory']);
                      },
                    ),
                    Visibility(
                      visible: controller.visibleCategory,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.groupsADCTR.listCategory.length,
                        itemBuilder: (context, index) => SuhContainer(
                          height: 40,
                          color: SuhColors.container,
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          radius: 10,
                          child: InkWell(
                            onTap: () {
                              controller.selectCategory = controller
                                  .groupsADCTR.listCategory[index].name
                                  .toString();
                              controller.visibleCategory =
                                  !controller.visibleCategory;
                              controller.category =
                                  controller.groupsADCTR.listCategory[index];
                              controller.update(['visibleCategory']);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SuhText(
                                text: controller
                                    .groupsADCTR.listCategory[index].name
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomTaps(
              onTap: () => controller.addProduct(),
            ),
          ],
        ),
      ),
    );
  }
}
