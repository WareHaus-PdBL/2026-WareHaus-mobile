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
        final aisle = zone.aisles != null && index < zone.aisles!.length
            ? zone.aisles![index]
            : null;

        final capacity = aisle?.capacity ?? 0;
        final occupiedCapacity = aisle?.occupiedCapacity ?? 0;
        final totalShelves = aisle?.totalShelves ?? 0;
        final percent = capacity > 0
            ? (occupiedCapacity / capacity).clamp(0.0, 1.0)
            : 0.0;

        return InkWell(
          onTap: () async {
            await Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, _, _) => ZoneAisleDetailPage(
                  zoneId: zone.id,
                  zoneCode: zone.zoneCode,
                  aisleNumber: aisle?.aisleNumber ?? index + 1,
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
                      'Aisle ${index + 1 > 9 ? index + 1 : '0${index + 1}'}',
                      style: WHTypography.heading1,
                    ),
                    Text('$totalShelves shelves', style: WHTypography.caption),
                  ],
                ),
                CircularPercentIndicator(
                  radius: 15.0,
                  lineWidth: 3.5,
                  percent: percent,
                  progressColor: Colors.green,
                  backgroundColor: Colors.green.shade100,
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
