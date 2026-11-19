import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/responsive_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dishController = context.watch<DishesController>();
    final dishModifiersController = context.watch<DishModifiersController>();

    final stats = <_Stat>[
      _Stat(FluentIcons.food_20_regular, "Total Products",
          "${dishController.totalDishes}"),
      _Stat(FluentIcons.apps_list_20_regular, "Total Categories",
          "${dishController.totalCategories}"),
      _Stat(FluentIcons.food_20_regular, "Total Menus",
          "${dishController.listOfMenus.length}"),
      _Stat(FluentIcons.apps_add_in_20_regular, "Total Modifiers",
          "${dishModifiersController.modifiersCount}"),
    ];

    if (ResponsiveUtils.isMobile(context)) {
      return _MobileDashboard(stats: stats);
    }
    return _TabletDashboard(stats: stats);
  }
}

class _Stat {
  final IconData icon;
  final String title;
  final String value;
  const _Stat(this.icon, this.title, this.value);
}

Widget _statCard(_Stat s) => Card(
      child: ListTile(
        leading: Icon(s.icon),
        title: Text(s.title),
        subtitle: Text(s.value),
      ),
    );

// ---- Tablet: original layout ----
class _TabletDashboard extends StatelessWidget {
  const _TabletDashboard({required this.stats});

  final List<_Stat> stats;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: _statCard(stats[0])),
                horizontalSpaceSmall,
                Expanded(child: _statCard(stats[1])),
              ],
            ),
          ),
          verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: _statCard(stats[2])),
                horizontalSpaceSmall,
                Expanded(child: _statCard(stats[3])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Mobile: same cards, one per row ----
class _MobileDashboard extends StatelessWidget {
  const _MobileDashboard({required this.stats});
  final List<_Stat> stats;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: stats.length,
      separatorBuilder: (_, __) => verticalSpaceSmall,
      itemBuilder: (_, i) => _statCard(stats[i]),
    );
  }
}
