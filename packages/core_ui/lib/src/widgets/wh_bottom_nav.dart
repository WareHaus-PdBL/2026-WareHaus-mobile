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

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.grid_view_rounded),
      label: 'Zones',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_rounded),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape:
          const CircularNotchedRectangle(), // Memberikan lengkungan untuk FAB
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.grid_view_rounded,
              label: 'Zones',
              index: 0,
            ),

            const SizedBox(width: 40),

            _buildNavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              index: 1,
            ),
          ],
        ),
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
          Icon(icon, color: isSelected ? WHColors.secondary3 : WHColors.grey3),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? WHColors.secondary3 : WHColors.grey3,
            ),
          ),
        ],
      ),
    );
  }
}
