import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdummytest/common/reusable_text.dart';

import '../constants/app_constants.dart';
import 'app_style.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.color, this.onTap});

  final String text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(46.r),
            color: kPrimary,
          ),
          width: width,
          height: hieght * 0.065,
          child: Center(
            child: ReusableText(text: text, 
                style: appstyle(16, color ?? Color(kLight.value), FontWeight.w600),),
          ),
        ),);
  }
}