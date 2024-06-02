import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(this.text,{
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.fontFamily,
    this.wordSpacing,
    this.letterSpacing,
    this.height, this.textAlign,
  });

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? wordSpacing;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: color ?? Colors.black,
        fontSize: fontSize?.sp,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
      ),
    );
  }
}
