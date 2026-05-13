import 'package:flutter/material.dart';

import '../colors.dart';

class WHBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const WHBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: WHColors.surface,
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.grid_view_outlined,
            label: 'DASHBOARD',
            index: 0,
          ),

          _buildNavItem(
            icon: Icons.inventory_2_outlined,
            label: 'PRODUCTS',
            index: 1,
          ),

          _buildNavItem(icon: Icons.layers_outlined, label: 'ZONES', index: 2),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? WHColors.secondary : WHColors.grey),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? WHColors.secondary : WHColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
