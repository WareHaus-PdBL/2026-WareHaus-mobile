import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:zone/domain/entities/zone.dart';

class ZoneEditResult {
  const ZoneEditResult({
    required this.zoneName,
    required this.category,
    required this.description,
  });

  final String zoneName;
  final String category;
  final String description;
}

Future<ZoneEditResult?> showZoneEditDialog(
  BuildContext context,
  Zone zone,
) async {
  final zoneNameController = TextEditingController(text: zone.zoneName);
  final categoryController = TextEditingController(text: zone.category);
  final descriptionController = TextEditingController(text: zone.description);

  try {
    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (ctx) => _ZoneEditDialog(
        zoneNameController: zoneNameController,
        categoryController: categoryController,
        descriptionController: descriptionController,
      ),
    );

    if (shouldSave != true) return null;

    return ZoneEditResult(
      zoneName: zoneNameController.text.trim(),
      category: categoryController.text.trim(),
      description: descriptionController.text.trim(),
    );
  } finally {
    zoneNameController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
  }
}

class _ZoneEditDialog extends StatelessWidget {
  const _ZoneEditDialog({
    required this.zoneNameController,
    required this.categoryController,
    required this.descriptionController,
  });

  final TextEditingController zoneNameController;
  final TextEditingController categoryController;
  final TextEditingController descriptionController;

  static const _primaryOrange = Color(0xFFD94F1E);
  static const _borderColor = Color(0xFFDDDDDD);

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: WHColors.grey, fontSize: 13),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    filled: true,
    fillColor: WHColors.surface,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: _borderColor, width: 1.5),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: _borderColor, width: 1.5),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: _primaryOrange, width: 1.5),
    ),
  );

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: WHColors.textPrimary,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Row(
              children: [
                const Icon(
                  Icons.edit_outlined,
                  color: _primaryOrange,
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Edit Zone',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: WHColors.textPrimary,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.of(context).pop(false),
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.close, size: 18, color: WHColors.grey),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),
            const Text(
              'Update zone information below',
              style: TextStyle(fontSize: 12, color: WHColors.grey),
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, color: _borderColor),
            const SizedBox(height: 16),

            // ── Fields ──
            _label('Zone Name'),
            TextField(
              controller: zoneNameController,
              style: const TextStyle(fontSize: 13),
              decoration: _inputDecoration('e.g., Electronic'),
            ),
            const SizedBox(height: 14),

            _label('Category'),
            TextField(
              controller: categoryController,
              style: const TextStyle(fontSize: 13),
              decoration: _inputDecoration('e.g., Electronic'),
            ),
            const SizedBox(height: 14),

            _label('Description'),
            Stack(
              children: [
                TextField(
                  controller: descriptionController,
                  style: const TextStyle(fontSize: 13),
                  decoration: _inputDecoration('Add description here ...'),
                  maxLines: 3,
                ),
                const Positioned(
                  right: 10,
                  top: 8,
                  child: Text(
                    '(Optional)',
                    style: TextStyle(fontSize: 10, color: Color(0xFFB0B0B0)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Actions ──
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: _borderColor, width: 1.5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: WHColors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    icon: const Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryOrange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
