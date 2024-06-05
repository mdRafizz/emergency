import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.keyboardType,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.hintStyle,
    required this.controller,
    this.onChanged,
    this.width,
    this.label,
    this.height, this.color, this.obscureText,
  });

  final TextInputType? keyboardType;
  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final double? width;
  final double? height;
  final Color? color;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color?? const Color(0xffe8dcbe),
        borderRadius: const BorderRadius.all(Radius.circular(7),),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 25,
        obscureText: obscureText??false,
        onChanged: onChanged,
        style: const TextStyle(
            fontSize: 12,
            letterSpacing: 1.5,
            color: AppConstants.kBkDark,
            fontWeight: FontWeight.w100,
            fontFamily: 'poppins',),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: AppConstants.kBkDark,
            fontWeight: FontWeight.w100,
            // fontFamily: 'fira'
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: AppConstants.kBkDark,
          hintStyle: hintStyle,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
    );
  }
}
