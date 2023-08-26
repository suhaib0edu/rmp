import '../index_c.dart';
import 'index_widgets.dart';

class SuhButton extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final double? radius;
  final Widget? child;

  const SuhButton(
      {Key? key,
      this.onTap,
      this.onLongPress,
      this.padding,
      this.height,
      this.width,
      this.color,
      this.boxShadow,
      this.radius,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(radius ?? 22),
      child: Padding(
        padding: padding?? const EdgeInsets.all(1.0),
        child: SuhContainer(
          height: height ?? 40,
          width: width ?? 100,
          margin: const EdgeInsets.all(2),
          color: color,
          boxShadow: boxShadow,
          radius: radius ?? 20,
          child: Align(child: child),
        ),
      ),
    );
  }
}

class SuhTextButtonFill extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final double? height;
  final double? width;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final double? radius;
  final String title;
  final Color? titleColor;

  const SuhTextButtonFill(
      {Key? key,
      this.onTap,
      this.onLongPress,
      this.height,
      this.width,
      this.color,
      this.boxShadow,
      this.radius,
      required this.title,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuhButton(
      onTap: onTap,
      onLongPress: onLongPress,
      height: height,
      width: width,
      color: color,
      boxShadow: boxShadow,
      radius: radius,
      child: SuhText(
        text: title,
        color: titleColor ?? Colors.white70,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
