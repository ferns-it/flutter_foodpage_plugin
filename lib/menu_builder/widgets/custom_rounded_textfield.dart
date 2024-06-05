import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants/menu_builder_app_colors.dart';
import '../core/utils/ui_utils.dart'; // Import for InputFormatter

class CustomRoundedTextField extends StatelessWidget {
  const CustomRoundedTextField.topText({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    required String topText,
    this.margin = EdgeInsets.zero,
    this.textInputAction,
    this.keyboardType,
    this.padding,
    this.isDense = false,
    this.borderRadius,
    this.hintTextSize,
    this.fillColor,
    this.topTextColor,
    this.textEditingController,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialText,
    this.maxLines,
  })  : _topText = topText,
        super(key: key);

  const CustomRoundedTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.margin = EdgeInsets.zero,
    this.textInputAction,
    this.keyboardType,
    this.padding,
    this.isDense = false,
    this.borderRadius,
    this.hintTextSize,
    this.fillColor,
    this.topTextColor,
    this.textEditingController,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialText,
    this.maxLines,
  })  : _topText = null,
        super(key: key);

  final String hintText;
  final Icon? prefixIcon;
  final String? _topText;
  final String? initialText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final bool isDense;
  final BorderRadius? borderRadius;
  final double? hintTextSize;
  final Color? fillColor, topTextColor;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final int? maxLines;

  final void Function(String?)? onFieldSubmitted;

  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged; // Added onChanged parameter
  final List<TextInputFormatter>?
      inputFormatters; // Added inputFormatters parameter

  BorderSide get _borderSide => const BorderSide(
        color: MenuBuilderColors.kLightGrey,
        width: 1.5,
      );
  BorderRadius get _borderRadius => BorderRadius.circular(24.0);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (_topText == null) {
      return _buildTextField();
    }
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              _topText!,
              style: textTheme.titleSmall!.copyWith(
                color: topTextColor ?? Colors.grey.shade700,
              ),
            ),
          ),
          verticalSpaceTiny,
          _buildTextField(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Builder(builder: (context) {
      final textTheme = Theme.of(context).textTheme;
      return TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        controller: textEditingController,
        validator: validator,
        onChanged: onChanged, // Pass onChanged parameter
        inputFormatters: inputFormatters, // Pass inputFormatters parameter
        obscureText: obscureText,
        initialValue: initialText,
        onFieldSubmitted: onFieldSubmitted,
        maxLines: maxLines,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: _borderSide,
            borderRadius: borderRadius ?? _borderRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: _borderSide,
            borderRadius: borderRadius ?? _borderRadius,
          ),
          border: OutlineInputBorder(
            borderSide: _borderSide,
            borderRadius: borderRadius ?? _borderRadius,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          fillColor: fillColor,
          filled: fillColor != null,
          hintStyle: textTheme.titleMedium!.copyWith(
            color: MenuBuilderColors.kLightGrey2,
            fontSize: hintTextSize,
          ),
          contentPadding: padding,
          isDense: isDense,
        ),
      );
    });
  }
}
