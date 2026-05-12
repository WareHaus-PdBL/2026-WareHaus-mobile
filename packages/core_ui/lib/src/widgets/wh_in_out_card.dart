import 'package:core_ui/src/colors.dart';
import 'package:core_ui/src/typography.dart';
import 'package:flutter/material.dart';

class WHOrderCard extends StatelessWidget {
  final dynamic purchaseOrder;
  final VoidCallback? onTap;

  const WHOrderCard({super.key, required this.purchaseOrder, this.onTap});

  // Status helpers

  /// Normalise status string dari backend ke lowercase untuk matching.
  String get _status => purchaseOrder.status.toLowerCase();

  bool get _isQueued => _status == 'queued' || _status == 'pending';
  bool get _isActive => _status == 'active' || _status == 'processing';
  bool get _isCompleted => _status == 'completed' || _status == 'done';

  Color get _cardBackground {
    if (_isCompleted) return WHColors.success4;
    if (_isQueued) return WHColors.grey5;
    return WHColors.surface; // active
  }

  // Progress

  bool get _showProgress => _isActive || _isCompleted;

  int get _progressCurrent => purchaseOrder.progressCurrent ?? 0;
  int get _progressTotal =>
      purchaseOrder.progressTotal ?? purchaseOrder.items.length;

  double get _progressRatio => _progressTotal == 0
      ? 0
      : (_progressCurrent / _progressTotal).clamp(0.0, 1.0);

  // Build

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: _cardBackground,
              borderRadius: BorderRadius.circular(4),
              border: Border(
                left: BorderSide(
                  color: _isCompleted
                      ? WHColors.success2
                      : _isQueued
                      ? Colors.transparent
                      : WHColors.grey3,
                  width: 4,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: label + badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PURCHASE ORDER',
                        style: WHTypography.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      _StatusBadge(status: purchaseOrder.status),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // PO Number
                  Text(
                    purchaseOrder.poNumber,
                    style: WHTypography.heading1.copyWith(fontSize: 22),
                  ),

                  const SizedBox(height: 12),

                  // Queued: tampilkan tanggal + supplier berdampingan
                  if (_isQueued)
                    Row(
                      children: [
                        Expanded(
                          child: _InfoColumn(
                            label: 'Created At',
                            value: _formatDate(purchaseOrder.orderDate),
                          ),
                        ),
                        Expanded(
                          child: _InfoColumn(
                            label: 'Carrier',
                            value: purchaseOrder.supplierName,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    // Active / Completed: supplier satu baris
                    _InfoColumn(
                      label: 'Carrier',
                      value: purchaseOrder.supplierName,
                    ),

                    // Progress bar
                    if (_showProgress) ...[
                      const Divider(color: WHColors.grey5, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Unloading Progress',
                            style: WHTypography.caption,
                          ),
                          Text(
                            '$_progressCurrent / $_progressTotal Pallets',
                            style: WHTypography.caption.copyWith(
                              color: _isCompleted
                                  ? WHColors.success1
                                  : WHColors.secondary3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          value: _progressRatio,
                          minHeight: 6,
                          backgroundColor: WHColors.grey5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _isCompleted
                                ? WHColors.success2
                                : WHColors.secondary3,
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final dd = date.day.toString().padLeft(2, '0');
    final mm = date.month.toString().padLeft(2, '0');
    final yyyy = date.year;
    return '$dd/$mm/$yyyy';
  }
}

// Internal widgets

class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;
  const _InfoColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: WHTypography.caption),
        const SizedBox(height: 2),
        Text(
          value,
          style: WHTypography.bodyText.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase();
    final bool isQueued = s == 'queued' || s == 'pending';
    final bool isCompleted = s == 'completed' || s == 'done';

    final Color bg = isCompleted
        ? WHColors.success2
        : isQueued
        ? WHColors.grey5
        : WHColors.secondary4;

    final Color fg = isQueued ? WHColors.grey3 : Colors.white;
    final Color border = isQueued ? WHColors.grey4 : Colors.transparent;

    final IconData icon = isCompleted
        ? Icons.check_circle
        : isQueued
        ? Icons.access_time_rounded
        : Icons.circle;

    final double iconSize = (!isQueued && !isCompleted) ? 8 : 14;

    final String label = isCompleted
        ? 'Completed'
        : isQueued
        ? 'Queued'
        : 'Active';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: fg),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
