import 'package:rmp/widgets/index_widgets.dart';
import '../../index_c.dart';

class WContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double? radius;

  const WContainer(
      {Key? key, this.child, this.height, this.margin, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuhContainer(
      height: height ?? 40,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      color: SuhColors.container,
      radius: radius ?? 20,
      child: child,
    );
  }
}

class ContainerTextWithIcon extends StatelessWidget {
  final String? title;
  final void Function()? onTap;

  const ContainerTextWithIcon({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: WContainer(
          margin: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SuhText(
                text: title ?? 'المنتجات',
              ),
              Icon(
                Icons.arrow_right_outlined,
                color: SuhColors.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopTaps extends StatelessWidget {
  final String? title;

  const TopTaps({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuhContainer(
      margin: const EdgeInsets.only(bottom: 20),
      height: 45,
      color: SuhColors.background2,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 40,
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () => Get.back(),
                        child: SuhContainer(
                          margin: EdgeInsets.only(right: 16),
                          padding: EdgeInsets.only(left: 6,right: 10,top: 4 ,bottom: 4),
                          radius: 20,
                          color: SuhColors.container,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: SuhColors.text,
                            size: 20,
                          ),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 35,),
                  SuhText(
                    text: title ?? 'الواجهات',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomTaps extends StatelessWidget {
  final void Function()? onTap;
  final String? titleButton;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final bool visibleGreenButton;

  const BottomTaps(
      {Key? key,
      this.onTap,
      this.titleButton,
      this.padding,
      this.height,
      this.visibleGreenButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuhContainer(
      height: height ?? 70,
      color: SuhColors.list,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SuhTextButtonFill(
              title: 'تراجع',
              color: SuhColors.buttonO,
              onTap: () => Get.back(),
            ),
            Visibility(
              visible: visibleGreenButton,
              child: SuhTextButtonFill(
                title: titleButton ?? 'تأكيد',
                color: SuhColors.buttonG,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemListOrderContainer extends StatelessWidget {
  final bool isEdit;
  final String? title;
  final void Function()? onTapD;
  final void Function()? onTapE;
  final void Function()? onSelectTap;
  final bool isSelected;
  final String? hintText;

  const ItemListOrderContainer(
      {Key? key,
      this.isEdit = false,
      this.title,
      this.onTapD,
      this.onTapE,
      this.onSelectTap,
      this.isSelected = false,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 28;
    return WContainer(
      child: Row(
        children: [
          SuhSelect(
            isSelected: isSelected,
            onTap: onSelectTap,
          ),
          const SizedBox(
            width: 8,
          ),
          SuhText(
            text: title ?? 'فول',
            fontSize: 17,
          ),
          const Spacer(),
          SuhButton(
            height: isEdit ? size : 18,
            width: isEdit ? size : 18,
            radius: 5,
            color: SuhColors.delete,
            onTap: onTapD,
            child: isEdit
                ? Icon(
                    Icons.delete_outline,
                    color: SuhColors.text,
                    size: 20,
                  )
                : SuhContainer(
                    height: 1.5,
                    width: 10,
                    color: SuhColors.text,
                  ),
          ),
          isEdit
              ? const SizedBox()
              : SuhContainer(
                  height: 28,
                  width: 28,
                  radius: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  color: SuhColors.background2,
                  child: Stack(
                    children: [
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: SuhColors.text),
                      ),
                      Align(child: SuhText(text: hintText??'')),
                    ],
                  ),
                ),
          SuhButton(
            height: isEdit ? size : 18,
            width: isEdit ? size : 18,
            radius: 5,
            color: SuhColors.edit,
            onTap: onTapE,
            child: isEdit
                ? Icon(
                    Icons.mode_edit_outline_outlined,
                    color: SuhColors.text,
                    size: 20,
                  )
                : Icon(
                    Icons.add,
                    size: 18,
                    color: SuhColors.text,
                  ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}

class ListOrderContainer extends StatelessWidget {
  final String? text;
  final void Function()? onTap;

  const ListOrderContainer({Key? key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SuhContainer(
          height: 45,
          radius: 10,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          color: SuhColors.list,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SuhText(
                text: text ?? 'الوجبات',
                fontSize: 15,
              ),
              Icon(
                Icons.expand_more,
                color: SuhColors.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionsContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;

  const SubscriptionsContainer({Key? key, this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuhContainer(
      margin: const EdgeInsets.all(4),
      height: 75,
      color: color ?? SuhColors.container,
      radius: 20,
      child: child,
    );
  }
}

class PackagesContainer extends StatelessWidget {
  final String? title;
  final Color? color;
  final String? day;
  final String? price;

  const PackagesContainer(
      {Key? key, this.color, this.title, this.day = '90', this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubscriptionsContainer(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SuhText(
            text: title ?? 'الباقة الفضية',
            fontSize: 18,
          ),
          SuhContainer(
            height: 50,
            width: 140,
            radius: 15,
            padding: const EdgeInsets.all(8),
            color: SuhColors.background.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SuhText(
                    text: '$day يوم',
                    fontSize: 15,
                    color: SuhColors.text.withOpacity(0.8)),
                VerticalDivider(
                  color: SuhColors.text.withOpacity(0.8),
                  width: 2,
                  thickness: 2,
                ),
                SuhText(
                  text: price ?? '10 الف',
                  fontSize: 15,
                  color: SuhColors.text.withOpacity(0.8),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_back_ios_new,
            color: SuhColors.text,
          ),
        ],
      ),
    );
  }
}
