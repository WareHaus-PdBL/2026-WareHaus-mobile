import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class WHAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const WHAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toUpperCase(), style: WHTypography.title),
      backgroundColor: WHColors.surface,
      centerTitle: true,
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(color: WHColors.primary3, width: 0.5),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
