import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import 'app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hintText, required this.keyboardType, this.validator, this.suffixIcon, this.obscureText});

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        color: kbg.withOpacity(.4),
        child: TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
      
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: appstyle(14, Color(kDarkGrey.value), FontWeight.w500),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.red, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Color(kDarkGrey.value),
                width: 0,
              ),
            ),enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            border: InputBorder.none,
          ),
          controller: controller,
          cursorHeight: 25,
          style: appstyle(14, Color(kDark.value), FontWeight.w500),
          validator: validator,
        ),
      ),
    );
  }
}
