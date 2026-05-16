import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zone/presentation/pages/zone_aisle_detail_page.dart';
import 'package:zone/zone.dart';

class ZoneVisualizer extends StatelessWidget {
  final Zone zone;

  const ZoneVisualizer({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: zone.totalAisle,
      itemBuilder: (context, index) {
        final aisleNumber = index + 1;

        // Calculate aisle data from shelves
        final aisleShelves =
            zone.shelves
                ?.where((shelf) => shelf.aisle == aisleNumber)
                .toList() ??
            [];

        final totalShelves = aisleShelves.length;
        final totalCapacity = aisleShelves.fold<int>(
          0,
          (sum, shelf) => sum + shelf.capacity,
        );
        final occupiedCapacity = aisleShelves.fold<int>(
          0,
          (sum, shelf) => sum + shelf.currentVolume,
        );

        final percent = totalCapacity > 0
            ? (occupiedCapacity / totalCapacity).clamp(0.0, 1.0)
            : 0.0;

        final color = WHColors.primary3;

        return InkWell(
          onTap: () async {
            await Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, _, _) => ZoneAisleDetailPage(
                  zoneId: zone.id,
                  zoneCode: zone.zoneCode,
                  aisleNumber: aisleNumber,
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: WHColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: WHColors.grey.withOpacity(0.12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aisle ${aisleNumber > 9 ? aisleNumber : '0$aisleNumber'}',
                      style: WHTypography.heading1,
                    ),
                    Text(
                      '$totalShelves shelves | ${occupiedCapacity.toString()}/${totalCapacity.toString()} cap | ${(aisleShelves.length)} items',
                      style: WHTypography.caption,
                    ),
                  ],
                ),
                CircularPercentIndicator(
                  radius: 15.0,
                  lineWidth: 3.5,
                  percent: percent,
                  progressColor: color,
                  backgroundColor: color.withOpacity(0.3),
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
