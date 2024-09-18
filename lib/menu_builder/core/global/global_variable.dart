import 'package:flutter/material.dart';

class MenuBuilderGlobalVariable {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  static BuildContext get context => navState.currentContext!;
}