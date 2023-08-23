import '../index_c.dart';

class SuhText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;

  const SuhText(
      {Key? key,
      required this.text,
      this.color,
      this.fontWeight,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? SuhColors.text,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize,
      ),
    );
  }
}
