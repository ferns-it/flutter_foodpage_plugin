import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderRegistrar {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => PageNavigationController()),
  ];
}
