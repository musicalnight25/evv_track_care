import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class ButtonBorder {
  final double width;
  final Color color;

  ButtonBorder({required this.width, required this.color});
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? color;
  final BoxShape? shape;
  final double? size;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BorderRadius? radius;
  final ButtonBorder? border;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.child,
    this.color,
    this.shape,
    this.border,
    this.padding,
    this.size,
    this.height,
    this.width,
    this.borderRadius,
    this.radius,
    this.alignment,
  })  : assert(
            size == null || (height == null && width == null),
            "\n\nIf you give size, it will apply as height and width\n"
            "Consider give height and width or size.\n"),
        assert(radius == null || borderRadius == null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: radius ?? BorderRadius.circular(borderRadius ?? 10),
      child: Container(
        alignment: alignment,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.7.h),
        height: size ?? height,
        width: size ?? width,
        decoration: BoxDecoration(
          color: color ?? AppColors.theme,
          borderRadius: radius ?? BorderRadius.circular(borderRadius ?? 10),
          border: Border.all(color: border?.color ?? AppColors.theme, width: border?.width ?? 1),
          shape: shape ?? BoxShape.rectangle,
        ),
        child: child,
      ),
    );
  }
}
