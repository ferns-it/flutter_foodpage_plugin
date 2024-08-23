import 'package:flutter/material.dart';

import '../../core/constants/menu_builder_app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.onSearchChanged,
    required this.searchTextController,
    this.borderRadius,
    this.fillColor = MenuBuilderColors.kWhite2,
  });

  static const double _borderRadius = 10.0;

  final void Function(String? query) onSearchChanged;
  final TextEditingController searchTextController;
  final double? borderRadius;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search...',
        focusedBorder: _inputFocusBorder,
        border: _inputBorder,
        errorBorder: _inputBorder,
        enabledBorder: _inputBorder,
        contentPadding: EdgeInsets.zero,
      ),
      onChanged: onSearchChanged,
      controller: searchTextController,
    );
  }

  OutlineInputBorder get _inputFocusBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: MenuBuilderColors.kPrimaryColor),
        borderRadius: BorderRadius.circular(borderRadius ?? _borderRadius),
      );

  OutlineInputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(borderRadius ?? _borderRadius),
      );
}
