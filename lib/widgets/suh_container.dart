import '../index_c.dart';

class SuhContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final double? radius;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  const SuhContainer(
      {Key? key,
      this.height,
      this.width,
      this.padding,
      this.margin,
      this.color,
      this.boxShadow,
      this.borderRadius,
      this.radius,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        boxShadow: boxShadow,
        borderRadius:
            radius != null ? BorderRadius.circular(radius ?? 0) : borderRadius,
      ),
      child: child,
    );
  }
}
