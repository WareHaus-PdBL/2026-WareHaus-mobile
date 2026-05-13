import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:zone/zone.dart';

class ZoneVisualizer extends StatelessWidget {
  final Zone zone;

  const ZoneVisualizer({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Text(
            "Warehouse Grid : ${zone.zoneCode}",
            style: WHTypography.heading2.copyWith(color: WHColors.grey1),
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: zone.totalAisles * zone.totalShelves,
            itemBuilder: (context, index) {
              int aisle = index ~/ zone.totalShelves + 1;
              int shelf = index % zone.totalShelves + 1;

              return Container(
                decoration: BoxDecoration(
                  color: WHColors.primary5.withValues(alpha: 0.1),
                  border: Border.all(color: WHColors.primary1, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shelves,
                      color: WHColors.primary5,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Aisle $aisle",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Shelf $shelf"),
                    const Text(
                      "Capacity: 100",
                      style: TextStyle(fontSize: 10, color: Colors.green),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
