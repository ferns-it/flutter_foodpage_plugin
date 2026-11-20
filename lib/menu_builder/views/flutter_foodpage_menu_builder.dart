import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/auth/auth_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_category_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/google_ai/gemini_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/shop/shop_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_theme.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/responsive_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/menu_builder_config.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/category/categories_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/common/root/base_root_widget.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/dashboard/dashboard_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/food_menu_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/food_details_side_sheet_widget.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/modifier/widgets/add_update_modifer_side_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../core/constants/menu_builder_app_colors.dart';
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
  final AuthController _authController = AuthController();
  final PageNavigationController _pageNavigationController =
      PageNavigationController();
  final GeminiController _geminiController = GeminiController();
  final DishesController _dishesController = DishesController();
  final DishCategoryController _dishCategoryController =
      DishCategoryController();
  final DishModifiersController _dishModifiersController =
      DishModifiersController();
  final ShopController _shopController = ShopController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loginMenuBuilder());
  }

  void _loginMenuBuilder() {
    _authController.loginMenuBuilder(widget.config);
    _geminiController.initializeGemini(widget.config.geminiAPIKey);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    final bottom = mq.viewInsets.bottom;

    List<Widget> screens = [
      const DashboardScreen(),
      const FoodMenuScreen(),
      const CategoriesScreen(),
      const ModifiersScreen(),
    ];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authController),
        ChangeNotifierProvider.value(value: _pageNavigationController),
        ChangeNotifierProvider.value(value: _geminiController),
        ChangeNotifierProvider.value(value: _dishesController),
        ChangeNotifierProvider.value(value: _dishCategoryController),
        ChangeNotifierProvider.value(value: _dishModifiersController),
        ChangeNotifierProvider.value(value: _shopController),
      ],
      child: Builder(builder: (providerContext) {
        final authController = providerContext.watch<AuthController>();

        return Theme(
          data: menuBuilderTheme(context),
          child: Scaffold(
              backgroundColor: MenuBuilderColors.kWhite2,
              body: authController.authenticationDetails.when(initial: () {
                return const SizedBox.shrink();
              }, loading: () {
                return const Center(
                  child: _LoadingWidget(),
                );
              }, completed: (_) {
                return Builder(builder: (navContext) {
                  final pageNavigationController =
                      navContext.watch<PageNavigationController>();
                  final currentPageIndex =
                      pageNavigationController.currentPageIndex;
                  return BaseRootWidget(
                    endDrawer: currentPageIndex == 1 || currentPageIndex == 3
                        ? Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: size.height - bottom,
                              child: currentPageIndex == 1
                                  ? const FoodDetailsSideSheetWidget()
                                  : const AddUpdateModifierSideSheet(),
                            ),
                          )
                        : null,
                    child: Expanded(
                      child: screens[pageNavigationController.currentPageIndex %
                          screens.length],
                    ),
                  );
                });
              }, error: (message, error) {
                return Center(
                  child: _ErrorWidget(
                    errorText: error?.message,
                    onPressRetry: _loginMenuBuilder,
                  ),
                );
              })),
        );
      }),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: isMobile ? width * 0.88 : width / 3,
          child: Card(
            color: Colors.white,
            elevation: 4.0,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 10.0,
                vertical: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  verticalSpaceRegular,
                  Image.asset(
                    "packages/flutter_foodpage_plugin/assets/images/food-page-logo.png",
                    height: isMobile ? 36 : 45,
                  ),
                  verticalSpaceRegular,
                  Text(
                    "Build and manage your menu effortlessly with Menu Builder!",
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 15 : 18,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: isMobile ? 150 : 180,
                    child: LottieBuilder.asset(
                      "packages/flutter_foodpage_plugin/assets/animations/loading_animation.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    super.key,
    this.errorText,
    required this.onPressRetry,
  });

  final String? errorText;
  final VoidCallback onPressRetry;

  static const _defaultErrorMessage = "Something went wrong, Please try again";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Card(
            color: Colors.white,
            elevation: 4.0,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 140,
                    child: LottieBuilder.asset(
                      "packages/flutter_foodpage_plugin/assets/animations/error_animation.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                  verticalSpaceRegular,
                  Text(
                    "Failed to Login Menu Builder",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  verticalSpaceTiny,
                  Text(
                    errorText ?? _defaultErrorMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      height: 0.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceSmall,
                  FilledButton(
                    onPressed: onPressRetry,
                    child: const Text("Retry"),
                  ),
                  verticalSpaceRegular,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
