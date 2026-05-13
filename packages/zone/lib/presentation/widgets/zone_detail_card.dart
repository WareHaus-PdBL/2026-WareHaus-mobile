import 'package:core_ui/src/colors.dart';
import 'package:core_ui/src/typography.dart';
import 'package:flutter/material.dart';
import 'package:zone/zone.dart';

class ZoneDetailCard extends StatelessWidget {
  final Zone zone;

  const ZoneDetailCard({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: WHColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: WHColors.grey.withOpacity(0.12)),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: WHColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        zone.zoneCode,
                        style: WHTypography.heading2.copyWith(
                          color: WHColors.surface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            zone.zoneName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: WHTypography.heading1,
                          ),
                          Text(
                            zone.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: WHTypography.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: WHColors.grey, width: 1.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              zone.totalAisle.toString(),
                              style: WHTypography.title,
                            ),
                            Text('AISLES', style: WHTypography.bodyText),
                          ],
                        ),
                        Container(color: WHColors.grey, height: 50, width: 1.5),
                        Column(
                          children: [
                            Text(
                              (zone.totalAisle * zone.shelfPerAisle).toString(),
                              style: WHTypography.title,
                            ),
                            Text('SHELVES', style: WHTypography.bodyText),
                          ],
                        ),
                        Container(color: WHColors.grey, height: 50, width: 1.5),
                        Column(
                          children: [
                            Text(
                              zone.emptyShelves.toString(),
                              style: WHTypography.title.copyWith(
                                color: WHColors.secondary,
                              ),
                            ),
                            Text('EMPTY', style: WHTypography.bodyText),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
