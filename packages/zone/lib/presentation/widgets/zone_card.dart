import 'package:core_ui/src/colors.dart';
import 'package:core_ui/src/typography.dart';
import 'package:flutter/material.dart';
import 'package:zone/zone.dart';

class ZoneCard extends StatelessWidget {
  final Zone zone;
  final VoidCallback? onTap;

  const ZoneCard({super.key, required this.zone, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: WHColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: WHColors.grey3.withValues(alpha: 0.12)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: WHColors.secondary5,
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
                          style: WHTypography.bodyText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Category: ${zone.category}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: WHTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: WHColors.grey3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
