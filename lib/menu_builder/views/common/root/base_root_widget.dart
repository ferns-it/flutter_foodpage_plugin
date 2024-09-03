import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/core/menu_builder_dependency_registrar.dart';

import '../../../core/constants/menu_builder_theme.dart';
import '../../../core/utils/ui_utils.dart';
import '../header/header_widget.dart';
import '../side_menu/side_menu_widget.dart';

class BaseRootWidget extends StatefulWidget {
  const BaseRootWidget({
    super.key,
    required this.child,
    this.endDrawer,
  });

  final Widget child;
  final Widget? endDrawer;

  @override
  State<BaseRootWidget> createState() => _BaseRootWidgetState();
}

class _BaseRootWidgetState extends State<BaseRootWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MenuBuilderDependencyRegistrar.initializeAllProviders(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: menuBuilderTheme(context),
      child: Scaffold(
        endDrawer: widget.endDrawer,

        endDrawerEnableOpenDragGesture: false,
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
                    widget.child,
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
