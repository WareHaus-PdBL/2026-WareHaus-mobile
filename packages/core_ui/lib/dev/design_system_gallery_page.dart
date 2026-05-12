import 'package:flutter/material.dart';
import '../src/widgets/button/wh_button_primary.dart';
import '../src/widgets/button/wh_button_secondary.dart';
import '../src/widgets/button/wh_button_tersiery.dart';
import '../src/widgets/wh_appbar.dart';
import '../src/widgets/wh_in_out_card.dart';
import '../src/colors.dart';
import 'package:zone/zone.dart';

class _DummyOrder {
  final String poNumber;
  final String supplierName;
  final String status;
  final DateTime orderDate;
 
  /// Dipakai saat status == 'active' atau 'completed'.
  final int? progressCurrent;
 
  /// Dipakai saat status == 'active' atau 'completed'.
  final int? progressTotal;
 
  /// Fallback: jika [progressTotal] null, WHOrderCard pakai items.length.
  final List<Object> items;
 
  const _DummyOrder({
    required this.poNumber,
    required this.supplierName,
    required this.status,
    required this.orderDate,
    this.progressCurrent,
    this.progressTotal,
    this.items = const [],
  });
}
 
// Tiga data dummy – satu per status
final _dummyQueued = _DummyOrder(
  poNumber: 'PO-9105-Z',
  supplierName: 'National Trans',
  status: 'Queued',
  orderDate: DateTime(2026, 5, 25),
  items: [],
);
 
final _dummyActive = _DummyOrder(
  poNumber: 'PO-8832-A',
  supplierName: 'Maju Jaya Logistics',
  status: 'Active',
  orderDate: DateTime(2026, 5, 20),
  progressCurrent: 18,
  progressTotal: 45,
  items: [],
);
 
final _dummyCompleted = _DummyOrder(
  poNumber: 'PO-7741-C',
  supplierName: 'Sinar Mas Freight',
  status: 'Completed',
  orderDate: DateTime(2026, 5, 15),
  progressCurrent: 45,
  progressTotal: 45,
  items: [],
);

class DesignSystemGalleryPage extends StatefulWidget {
  const DesignSystemGalleryPage({super.key});

  @override
  State<DesignSystemGalleryPage> createState() =>
      _DesignSystemGalleryPageState();
}

class _DesignSystemGalleryPageState extends State<DesignSystemGalleryPage> {
  @override
  Widget build(BuildContext context) {
    // Data dummy buat testing
    final dummyZone = Zone(
      id: '1',
      zoneCode: 'A',
      zoneName: 'Dry Food Area',
      category: 'Food',
      totalAisles: 9,
      totalShelves: 3,
      shelvesCapacity: 100,
    );

    return Scaffold(
      backgroundColor: WHColors.background,
      appBar: AppBar(title: WHAppbar(title: 'Design System')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionTitle('Primary Buttons'),
          const Text(
            'Active State',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          WhPrimaryButton(
            text: 'Done',
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Button Pressed!')));
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Disabled State',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          const WhPrimaryButton(text: 'Done', onPressed: null),
          const SizedBox(height: 32),
          const SizedBox(height: 10), // Space extra di bawah

          _buildSectionTitle('Secondary Buttons'),
          const Text(
            'Active State',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          WhSecondaryButton(
            text: 'Done',
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Button Pressed!')));
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Disabled State',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          const WhSecondaryButton(text: 'Done', onPressed: null),
          const SizedBox(height: 32),
          const SizedBox(height: 10),

          _buildSectionTitle('Tersier Buttons'),
          const Text(
            'Active State',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          WhTersieryButton(
            text: 'Done',
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Button Pressed!')));
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Disabled State',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          const WhTersieryButton(text: 'Done', onPressed: null),
          const SizedBox(height: 32),
          const SizedBox(height: 10),

          _buildSectionTitle('Zone Management Card'),
          const Text(
            'Zone Card',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          ZoneCard(zone: dummyZone),

          _buildSectionTitle('Inbound Card'),
          const Text(
            'Queued',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          WHOrderCard(
            purchaseOrder: _dummyQueued,
            onTap: () {},
          ),
          const SizedBox(height: 16),

          const Text(
            'Active',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          WHOrderCard(
            purchaseOrder: _dummyActive,
            onTap: () {},
          ),
          const SizedBox(height: 16),

          const Text(
            'Completed',
            style: TextStyle(color: WHColors.primary1, fontSize: 12),
          ),
          const SizedBox(height: 8),
          WHOrderCard(
            purchaseOrder: _dummyCompleted,
            onTap: null,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: WHColors.primary1,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.white24),
        ],
      ),
    );
  }
}
