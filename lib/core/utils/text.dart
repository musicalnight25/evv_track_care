// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overFlow;
  final int? maxLines;
  final double? height;
  final List<Shadow>? shadows;

  const Txt(
    this.title, {
    super.key,
    this.height,
    this.bgColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overFlow,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overFlow,
      maxLines: maxLines,
      style: TxtStyle(
        shadows: shadows,
        fontSize: fontSize,
        textColor: textColor,
        fontWeight: fontWeight,
        bgColor: bgColor,
        height: height ?? 1.35,
      ),
    );
  }
}

TextStyle TxtStyle({
  Color? bgColor,
  Color? textColor,
  double? fontSize,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  double? height,
  List<Shadow>? shadows,
}) =>
    TextStyle(
      backgroundColor: bgColor,
      shadows: shadows,
      color: textColor ?? Colors.black,
      fontSize: fontSize,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: "HurmeGeometricSans1",
      height: height,
    );
