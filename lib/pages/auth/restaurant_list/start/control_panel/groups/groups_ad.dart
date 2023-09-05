

import '../../../../../../index_c.dart';
import '../../../../../../widgets/index_widgets.dart';
import '../../../../../../widgets/w_items/index_w_items.dart';
import 'groups_ad_ctr.dart';

class GroupsAD extends GetView<GroupsADCTR> {
  const GroupsAD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupsADCTR());
    return Scaffold(
      backgroundColor: SuhColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            const TopTaps(
              title: 'المجموعات',
            ),
            ContainerTextWithIcon(
              title: 'إضافة مجموعة',
              onTap: () => Get.bottomSheet(categoryItemView()),
            ),
            GetBuilder<GroupsADCTR>(
              id: 'getAllCategory',
              builder: (context) => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.listCategory.length,
                itemBuilder: (context, index) => ItemListOrderContainer(
                  title: controller.listCategory[index].name,
                  isEdit: true,
                  onTapD: () => controller
                      .deleteCategory(controller.listCategory[index].id),
                  onTapE: () {
                    controller.categoryController.text = controller.listCategory[index].name.toString();
                    Get.bottomSheet(
                        categoryItemView(isEdit: true, id: controller
                            .listCategory[index].id));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItemView({bool isEdit = false, int? id}) {
    return SuhContainer(
      color: SuhColors.background,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SuhContainer(
              height: 8,
              width: 80,
              color: SuhColors.background2,
              radius: 8,
            ),
          ),
          SuhTextField(
            hintText: 'اسم المجموعة',
            controller: controller.categoryController,
          ),
          const SizedBox(
            height: 20,
          ),
          SuhTextButtonFill(
            title: 'إضافة',
            color: SuhColors.buttonG,
            onTap: () {
              if (isEdit) {
                if (id != null) {
                  controller.editCategory(id);
                }
              } else {
                controller.addCategory();
              }
            },
          ),
        ],
      ),
    );
  }
}
