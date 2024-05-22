import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/core/constant/strings.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  const AppTextField({super.key,  this.controller, this.hintText, this.validator});

  InputBorder get border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(35.r),
      borderSide: const BorderSide(color: Colors.transparent,width: 1)
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
      border: border,
      focusColor: Colors.transparent,
      focusedBorder: border,
      enabledBorder: border,
      prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              AppStrings.textSearchIcon,
              height: 30,
            ),
          ),
       prefixIconConstraints: const BoxConstraints(
            minWidth: 35,
            minHeight: 35,
          ),
        hintText: hintText,
          filled: true,
          fillColor: Colors.white,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff031420),
        )
      ),
    );
  }
}
