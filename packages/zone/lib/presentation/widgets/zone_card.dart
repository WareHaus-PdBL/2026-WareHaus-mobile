import 'package:core_ui/src/colors.dart';
import 'package:core_ui/src/typography.dart';
import 'package:core_ui/src/widgets/wh_shimmer.dart'; // Import helper shimmer kita
import 'package:flutter/material.dart';
import 'package:zone/zone.dart';

class ZoneCard extends StatelessWidget {
  final Zone zone;
  final VoidCallback? onTap;
  final bool isLoading;

  const ZoneCard({
    super.key,
    required this.zone,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: WHColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: WHColors.grey.withOpacity(0.12)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  isLoading
                      ? const WHShimmer(
                          width: 50,
                          height: 50,
                          borderRadius: null,
                        )
                      : Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: WHColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            zone.zoneCode,
                            style: WHTypography.heading2.copyWith(
                              color: WHColors.primary,
                            ),
                          ),
                        ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? const WHShimmer(width: 150, height: 20)
                            : Text(
                                zone.zoneName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: WHTypography.bodyText.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(height: 8),
                        isLoading
                            ? const WHShimmer(width: 100, height: 14)
                            : Text(
                                'Category: ${zone.category}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: WHTypography.caption,
                              ),
                      ],
                    ),
                  ),
                  if (!isLoading)
                    const Icon(Icons.chevron_right, color: WHColors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
