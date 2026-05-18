import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:zone/domain/entities/zone.dart';

/// Data hasil edit yang dikembalikan ke caller.
class ZoneEditResult {
  final String zoneName;
  final String category;
  final String description;

  const ZoneEditResult({
    required this.zoneName,
    required this.category,
    required this.description,
  });
}

/// Tampilkan dialog edit zone dan kembalikan [ZoneEditResult] jika user
/// menekan Save, atau null jika user membatalkan.
///
/// Dispatch event BLoC **setelah** Future ini selesai (dialog sudah
/// sepenuhnya di-dispose) agar tidak memicu assertion `_dependents.isEmpty`.
Future<ZoneEditResult?> showZoneEditDialog(BuildContext context, Zone zone) {
  return showDialog<ZoneEditResult>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ZoneEditDialog(zone: zone),
  );
}

class _ZoneEditDialog extends StatefulWidget {
  final Zone zone;

  const _ZoneEditDialog({required this.zone});

  @override
  State<_ZoneEditDialog> createState() => _ZoneEditDialogState();
}

class _ZoneEditDialogState extends State<_ZoneEditDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.zone.zoneName);
    _categoryController = TextEditingController(text: widget.zone.category);
    _descriptionController = TextEditingController(
      text: widget.zone.description,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Pop dulu — kembalikan result ke caller.
    // Caller wajib menunggu dialog ini selesai sebelum dispatch event BLoC
    // (gunakan await + Future.microtask) agar tidak ada dependents aktif
    // saat state berubah.
    Navigator.of(context).pop(
      ZoneEditResult(
        zoneName: _nameController.text.trim(),
        category: _categoryController.text.trim(),
        description: _descriptionController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: WHColors.surface,
      title: const Text('Edit Zone', style: WHTypography.heading1),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Zone Name
              TextFormField(
                controller: _nameController,
                style: WHTypography.bodyText,
                decoration: InputDecoration(
                  labelText: 'Zone Name',
                  labelStyle: WHTypography.caption,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.grey3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.error2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.error2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 12),

              // Category
              TextFormField(
                controller: _categoryController,
                style: WHTypography.bodyText,
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: WHTypography.caption,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.grey3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.error2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.error2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Category is required'
                    : null,
              ),
              const SizedBox(height: 12),

              // Description (opsional)
              TextFormField(
                controller: _descriptionController,
                style: WHTypography.bodyText,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description (optional)',
                  labelStyle: WHTypography.caption,
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.grey3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WHColors.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel', style: TextStyle(color: WHColors.grey3)),
        ),
        ElevatedButton(
          onPressed: _onSave,
          style: ElevatedButton.styleFrom(backgroundColor: WHColors.primary),
          child: const Text('Save', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
