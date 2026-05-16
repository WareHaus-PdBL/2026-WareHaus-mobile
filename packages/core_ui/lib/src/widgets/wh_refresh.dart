import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class WHRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? color;

  const WHRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? WHColors.primary,
      child: child,
    );
  }
}