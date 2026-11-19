import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/menu_navigation.dart';
import 'package:provider/provider.dart';

class MobileBottomNav extends StatelessWidget {
  const MobileBottomNav({super.key});

  static const _items = <_NavItem>[
    _NavItem(
      label: "Dashboard",
      icon: FluentIcons.home_20_regular,
      selectedIcon: FluentIcons.home_20_filled,
    ),
    _NavItem(
      label: "Menu",
      icon: FluentIcons.food_20_regular,
      selectedIcon: FluentIcons.food_20_filled,
    ),
    _NavItem(
      label: "Categories",
      icon: FluentIcons.apps_list_20_regular,
      selectedIcon: FluentIcons.apps_list_20_filled,
    ),
    _NavItem(
      label: "Modifiers",
      icon: FluentIcons.apps_add_in_20_regular,
      selectedIcon: FluentIcons.apps_add_in_20_filled,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final index = context.watch<PageNavigationController>().currentPageIndex;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: MenuBuilderColors.kWhite,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_items.length, (i) {
              return _NavButton(
                item: _items[i],
                selected: index == i,
                onTap: () {
                  if (index == i) return;
                  HapticFeedback.selectionClick();
                  MenuNavigation.goTo(context, i);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primary = MenuBuilderColors.kPrimaryColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: selected ? 16 : 12),
        decoration: BoxDecoration(
          color: selected ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? item.selectedIcon : item.icon,
              size: 22,
              color: selected ? Colors.white : Colors.grey.shade600,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              child: selected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        item.label,
                        maxLines: 1,
                        style: textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
