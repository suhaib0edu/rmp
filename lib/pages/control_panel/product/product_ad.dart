import 'package:rmp/pages/control_panel/product/add_product/add_prodact_ctr.dart';
import 'package:rmp/pages/control_panel/product/product_ad_ctr.dart';
import 'package:rmp/widgets/w_items/index_w_items.dart';

import '../../../index_c.dart';
import 'add_product/add_product.dart';

class ProductAD extends GetView<ProductADCTR> {
  const ProductAD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductADCTR());
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            const TopTaps(
              title: 'المنتجات',
            ),
            ContainerTextWithIcon(
              title: 'إضافة مننتج جديد',
              onTap: () => Get.to(() => const AddProductPage()),
            ),
            GetBuilder<ProductADCTR>(
              id: 'getAllProducts',
              builder: (context) => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.productList.length,
                itemBuilder: (context, index) => ItemListOrderContainer(
                  isEdit: true,
                  title: controller.productList[index].name,
                  onTapD: ()=> controller.deleteProduct(controller.productList[index].id),
                  onTapE: ()=> controller.editProduct(controller.productList[index].id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
