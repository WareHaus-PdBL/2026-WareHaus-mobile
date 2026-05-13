import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:product/domain/entities/stock.dart';

class ShelfCard extends StatelessWidget {
  final Stock? stock;
  const ShelfCard({super.key, this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WHColors.surface,
        border: Border(bottom: BorderSide(color: WHColors.grey, width: 1)),
      ),
      child: Row(
        children: [
          Text(
            stock == null ? 'Shelf -' : 'Shelf ${stock!.shelfId}',
            style: WHTypography.heading2.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            '${stock?.quantity ?? 0} PCS',
            style: WHTypography.bodyText.copyWith(color: WHColors.secondary4),
          ),
        ],
      ),
    );
  }
}
