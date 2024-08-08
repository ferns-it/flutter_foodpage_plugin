import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/auth/auth_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/google_ai/gemini_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/menu_builder_config.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/category/categories_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/common/root/base_root_widget.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/dashboard/dashboard_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/food_menu_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/food_details_side_sheet_widget.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/modifier/widgets/add_update_modifer_side_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'modifier/modifiers_screen.dart';

class FlutterFoodpageMenuBuilder extends StatefulWidget {
  const FlutterFoodpageMenuBuilder({super.key, required this.config});

  final MenuBuilderConfig config;

  @override
  State<FlutterFoodpageMenuBuilder> createState() =>
      _FlutterFoodpageMenuBuilderState();
}

class _FlutterFoodpageMenuBuilderState
    extends State<FlutterFoodpageMenuBuilder> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().loginMenuBuilder(widget.config);
      context
          .read<GeminiController>()
          .initializeGemini(widget.config.geminiAPIKey);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const DashboardScreen(),
      const FoodMenuScreen(),
      const CategoriesScreen(),
      const ModifiersScreen(),
    ];

    final controller = context.watch<AuthController>();

    return controller.authenticationDetails.when(initial: () {
      return const SizedBox.shrink();
    }, loading: () {
      return const Scaffold(
        body: Center(child: _LoadingWidget()),
      );
    }, completed: (_) {
      return Builder(builder: (context) {
        final pageNavigationController =
            context.watch<PageNavigationController>();
        final currentPageIndex = pageNavigationController.currentPageIndex;
        return BaseRootWidget(
          endDrawer: currentPageIndex == 1
              ? const FoodDetailsSideSheetWidget()
              : currentPageIndex == 3
                  ? const AddUpdateModiferSideSheet()
                  : null,
          child: Expanded(
            child: screens[
                pageNavigationController.currentPageIndex % screens.length],
          ),
        );
      });
    }, error: (message, error) {
      return Text(message ?? "");
    });
  }
}

class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget();

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget> {
  bool lottieIsLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: LottieBuilder.asset(
                      "packages/flutter_foodpage_plugin/assets/animations/loading.json",
                      onLoaded: (_) {
                        setState(() {
                          lottieIsLoaded = true;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Menu Builder Loading...",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: MenuBuilderColors.kBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              "Powered by Foodpage",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: MenuBuilderColors.kPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
