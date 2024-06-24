import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/core/menu_builder_dependency_registrar.dart';
import 'package:provider/provider.dart';

class DependencyRegisterWidget extends StatelessWidget {
  const DependencyRegisterWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MenuBuilderDependencyRegistrar.providers,
      child: child,
    );
  }
}
