import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ZoneLoadingSkeleton extends StatelessWidget {
  const ZoneLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          const WHShimmer(width: 60, height: 60), // Kotak Kode Zona
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WHShimmer(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 20,
                ), // Nama Zona
                const SizedBox(height: 8),
                const WHShimmer(width: 100, height: 14), // Kategori
              ],
            ),
          ),
        ],
      ),
    );
  }
}
