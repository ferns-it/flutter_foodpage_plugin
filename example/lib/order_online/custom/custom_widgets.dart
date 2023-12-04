import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.readOnly = false,
      this.textEditingController});
  final String hintText;
  final bool readOnly;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}

class TextFormFieldWithLabel extends StatelessWidget {
  const TextFormFieldWithLabel(
      {super.key,
      required this.title,
      this.hintText,
      this.textEditingController,  this.readOnly = false});
  final String title;
  final String? hintText;
  final TextEditingController? textEditingController;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children:  <Widget>[
            const SizedBox(width: 5.0),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 3.0,
        ),
        CustomTextFormField(
          textEditingController: textEditingController,
          hintText: hintText ?? "N/A",
          readOnly: true,
        )
      ],
    );
  }
}
