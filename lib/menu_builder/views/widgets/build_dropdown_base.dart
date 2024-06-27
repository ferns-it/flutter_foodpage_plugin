import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';

class BuildDropdownBase extends StatelessWidget {
  const BuildDropdownBase(
      {Key? key,
      this.height,
      this.padding,
      this.border,
      required this.child,
      this.borderRadius,
      this.margin})
      : super(key: key);

  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxBorder? border;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;

  BoxBorder get _borderSide => Border.all(
        color: MenuBuilderColors.kLightGrey,
        width: 1.5,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      margin: margin,
      padding: padding ?? const EdgeInsets.only(right: 16.0, left: 16.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        border: border ?? _borderSide,
      ),
      child: child,
    );
  }
}
