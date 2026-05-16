import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:product/domain/entities/stock.dart';

class ShelfCard extends StatelessWidget {
  final Stock? stock;
  const ShelfCard({super.key, this.stock});

  @override
  Widget build(BuildContext context) {
    final shelfLabel = stock?.shelfCode.isNotEmpty == true
        ? stock!.shelfCode
        : stock == null
            ? '-'
            : stock!.shelfId.toString();
    final locationLabel = stock?.locationName.isNotEmpty == true
        ? stock!.locationName
        : [stock?.zoneCode, stock?.zoneName]
              .where((value) => value != null && value!.isNotEmpty)
              .map((value) => value!)
              .join(' • ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WHColors.surface,
        border: Border(bottom: BorderSide(color: WHColors.grey, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shelf $shelfLabel',
                  style: WHTypography.heading2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  locationLabel.isNotEmpty ? locationLabel : 'No location data',
                  style: WHTypography.caption,
                ),
                const SizedBox(height: 4),
                Text(
                  'Aisle ${stock?.aisle ?? 0} • Zone ${stock?.zoneCode ?? ''}',
                  style: WHTypography.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${stock?.quantity ?? 0} PCS',
                style: WHTypography.bodyText.copyWith(
                  color: WHColors.secondary4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${stock?.shelfCurrentVolume ?? 0}/${stock?.shelfCapacity ?? 0}',
                style: WHTypography.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
