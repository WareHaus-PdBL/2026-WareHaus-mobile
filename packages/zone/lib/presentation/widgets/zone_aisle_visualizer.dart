import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zone/zone.dart';

class ZoneAisleVisualizer extends StatelessWidget {
  final Zone zone;

  const ZoneAisleVisualizer({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: zone.shelves?.length ?? 0,
      itemBuilder: (context, index) {
        final shelf = zone.shelves != null && index < zone.shelves!.length
            ? zone.shelves![index]
            : null;

        final shelfNumber = index + 1;
        final shelfCode = shelf?.shelfCode ?? 'N/A';
        final capacity = shelf?.capacity ?? 0;
        final currentVolume = shelf?.currentVolume ?? 0;
        final percent = capacity > 0
            ? (currentVolume / capacity).clamp(0.0, 1.0)
            : 0.0;

        final status = capacity > 0
            ? (currentVolume / capacity) >= 0.8
                  ? 'Full'
                  : (currentVolume / capacity) >= 0.5
                  ? 'Medium'
                  : (currentVolume / capacity) == 0.0
                  ? 'Empty'
                  : 'Available'
            : 'N/A';

        return InkWell(
          onTap: () async {
            // await Navigator.of(context).push(
            //   PageRouteBuilder(
            //     pageBuilder: (_, _, _) => ZoneAisleDetailPage(
            //       zoneId: zone.id,
            //       shelfNumber: shelf?.shelfNumber ?? index + 1,
            //     ),
            //     transitionDuration: Duration.zero,
            //     reverseTransitionDuration: Duration.zero,
            //   ),
            // );
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
                      'Shelf ${shelfNumber > 9 ? shelfNumber : '0$shelfNumber'}',
                      style: WHTypography.heading1,
                    ),
                    Text(
                      'Code: $shelfCode | Status: $status',
                      style: WHTypography.caption,
                    ),
                  ],
                ),
                CircularPercentIndicator(
                  radius: 15.0,
                  lineWidth: 3.5,
                  percent: percent,
                  progressColor: WHColors.secondary,
                  backgroundColor: WHColors.secondary.withOpacity(0.3),
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
