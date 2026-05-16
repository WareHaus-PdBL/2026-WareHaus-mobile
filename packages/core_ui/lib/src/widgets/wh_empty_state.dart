import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class WHEmptyState extends StatelessWidget {
  final String message;
  const WHEmptyState({super.key, this.message = "No data available"});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.info_outline_rounded, size: 64, color: WHColors.primary5),
        Text(message, style: WHTypography.bodyText, textAlign: TextAlign.center),
      ],
    ));
  }
}
