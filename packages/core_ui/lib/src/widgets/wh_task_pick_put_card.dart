import 'package:flutter/material.dart';
import '../colors.dart';
import '../typography.dart';
import 'button/wh_button_tersiery.dart';

/// Tipe task yang didukung oleh card ini.
enum WHTaskType { inbound, outbound }

class WHTaskPickPutData {
  /// Lokasi rak, mis. "ZONA A - LORONG 2 - RAK 05"
  final String location;
  final String sku;
  final String productName;
  final int requiredQty;
  final String unit;
  final WHTaskType taskType;

  const WHTaskPickPutData({
    required this.location,
    required this.sku,
    required this.productName,
    required this.requiredQty,
    this.unit = 'Units',
    required this.taskType,
  });
}

class WHTaskPickPutCard extends StatelessWidget {
  final WHTaskPickPutData data;

  /// Dipanggil ketika tombol "Scan" ditekan.
  final VoidCallback? onScanTap;

  const WHTaskPickPutCard({super.key, required this.data, this.onScanTap});

  // Label header berdasarkan tipe task

  // Build
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WHColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lokasi
                _LocationRow(location: data.location),
                const SizedBox(height: 12),
                // SKU + Nama Produk
                _ProductInfo(sku: data.sku, productName: data.productName),
                const SizedBox(height: 16),
                // Required Item
                _RequiredItem(qty: data.requiredQty, unit: data.unit),
                const SizedBox(height: 16),
                // Divider tipis
                const Divider(color: WHColors.grey5, height: 1),
                const SizedBox(height: 16),
                // Verify Barcode + Scan button
                _VerifyBarcodeSection(onScanTap: onScanTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: WHColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.grid_view_rounded,
            size: 16,
            color: WHColors.primary3,
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }

/// Baris lokasi rak dengan ikon pin.
class _LocationRow extends StatelessWidget {
  final String location;
  const _LocationRow({required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, size: 20, color: WHColors.secondary3),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            location.toUpperCase(),
            style: WHTypography.heading2.copyWith(
              fontSize: 18,
              letterSpacing: 0.4,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Chip SKU + nama produk di dalam kotak berwarna sekunder.
class _ProductInfo extends StatelessWidget {
  final String sku;
  final String productName;
  const _ProductInfo({required this.sku, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: WHColors.secondary6,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SKU: $sku',
            style: WHTypography.caption.copyWith(color: WHColors.secondary2),
          ),
          const SizedBox(height: 4),
          Text(
            productName,
            style: WHTypography.bodyText.copyWith(
              fontWeight: FontWeight.bold,
              color: WHColors.grey1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Baris "Required Item" beserta jumlah unit.
class _RequiredItem extends StatelessWidget {
  final int qty;
  final String unit;
  const _RequiredItem({required this.qty, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Item',
          style: WHTypography.caption.copyWith(color: WHColors.grey4),
        ),
        const SizedBox(height: 4),
        Text(
          '$qty $unit',
          style: WHTypography.bodyText.copyWith(
            fontWeight: FontWeight.w600,
            color: WHColors.grey1,
          ),
        ),
      ],
    );
  }
}

/// Label "Verify Barcode Item" + tombol Scan.
class _VerifyBarcodeSection extends StatelessWidget {
  final VoidCallback? onScanTap;
  const _VerifyBarcodeSection({this.onScanTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Verify Barcode Item',
          style: WHTypography.caption.copyWith(color: WHColors.grey4),
        ),
        const SizedBox(height: 10),
        // Scan button
        WhTersieryButton(text: 'Scan', icon: Icons.qr_code_scanner, onPressed:() {
          
        },),
      ],
    );
  }
}
