import 'package:example/order_online/constants/app_colors.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget buildAppbar(
    {required String title,
    bool centerTitle = true,
    double elevation = 8.0,
    required Widget widget }) {
  return AppBar(
    title: Text(
      title.toUpperCase(),
      style: const TextStyle(fontSize: 18.0),
    ),
    centerTitle: centerTitle,
    elevation: elevation,
    bottom: PreferredSize(preferredSize: const Size.fromHeight(1.0), child: widget),
  );
}
