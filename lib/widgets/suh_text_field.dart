import '../index_c.dart';
import 'w_items/index_w_items.dart';

class SuhTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? minLines;
  final double? radius;
  final bool readOnly;
  final Widget? suffixIcon;

  const SuhTextField(
      {Key? key, this.hintText, this.controller, this.keyboardType, this.minLines, this.radius, this.readOnly = false, this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WContainer(
      height: minLines != null ? double.parse('$minLines') * 35 : 55,
      radius: radius ?? 35,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
              hintText: hintText ?? 'اسم العميل',
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                  color: SuhColors.text.withOpacity(0.7),
                  fontSize: 15),
              border: InputBorder.none),
          style: TextStyle(color: SuhColors.text, fontSize: 13),
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: minLines,
        ),
      ),
    );
  }
}
