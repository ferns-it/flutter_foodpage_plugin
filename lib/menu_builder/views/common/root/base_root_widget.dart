import 'package:flutter/material.dart';

import '../../../core/constants/menu_builder_theme.dart';
import '../../../core/utils/ui_utils.dart';
import '../header/header_widget.dart';
import '../side_menu/side_menu_widget.dart';

class BaseRootWidget extends StatelessWidget {
  const BaseRootWidget({
    super.key,
    required this.child,
    this.endDrawer,
  });

  final Widget child;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: menuBuilderTheme(context),
      child: Scaffold(
        endDrawer: endDrawer,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SideMenuWidget(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HeaderWidget(),
                    verticalSpaceRegular,
                    child,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
