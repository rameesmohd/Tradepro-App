import 'package:flutter/material.dart';

import '../colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.height = 52,
    this.width = double.infinity,
    this.hintText,
    this.controller,
    this.onChanged,
  });

  final double? height;
  final double? width;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.backgroundSecondaryColor),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.textFieldBorder)),
            hintText: hintText,
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.textFieldBorder),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
