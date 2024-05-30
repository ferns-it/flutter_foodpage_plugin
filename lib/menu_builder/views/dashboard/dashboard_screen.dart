import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_theme.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/common/header/header_widget.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/common/side_menu/side_menu_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: menuBuilderTheme(context),
      child: const Scaffold(
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SideMenuWidget(),
              Expanded(child: HeaderWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
