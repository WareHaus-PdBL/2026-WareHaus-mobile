import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHColors.background,
      appBar: WHAppbar(title: 'Dashboard'),
      body: const Center(child: Text('Dashboard belum tersedia')),
    );
  }
}
