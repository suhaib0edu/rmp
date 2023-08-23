import 'package:rmp/widgets/index_widgets.dart';
import '../index_c.dart';

class SuhSelect extends StatelessWidget {
  final bool isSelected;
  final void Function()? onTap;
  const SuhSelect({Key? key, this.isSelected = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SuhContainer(
        height: 20,
        width: 20,
        radius: 20,
        color: SuhColors.background2,
        child: SuhContainer(
          margin: const EdgeInsets.all(4),
          radius: 20,
          color: isSelected? SuhColors.delete : SuhColors.background2,
        ),
      ),
    );
  }

}
