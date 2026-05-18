import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ProductEditResult {
  const ProductEditResult({
    required this.productName,
    required this.sku,
    required this.unitOfMeasure,
  });

  final String productName;
  final String sku;
  final String unitOfMeasure;
}

Future<ProductEditResult?> showProductEditDialog(
  BuildContext context, {
  required String initialName,
  required String initialSku,
  required String initialUom,
}) async {
  return showDialog<ProductEditResult>(
    context: context,
    builder: (ctx) => _ProductEditDialog(
      initialName: initialName,
      initialSku: initialSku,
      initialUom: initialUom,
    ),
  );
}

class _ProductEditDialog extends StatefulWidget {
  const _ProductEditDialog({
    required this.initialName,
    required this.initialSku,
    required this.initialUom,
  });

  final String initialName;
  final String initialSku;
  final String initialUom;

  @override
  State<_ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<_ProductEditDialog> {
  late final TextEditingController nameController;
  late final TextEditingController skuController;
  late final TextEditingController uomController;

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
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    skuController = TextEditingController(text: widget.initialSku);
    uomController = TextEditingController(text: widget.initialUom);
  }

  @override
  void dispose() {
    nameController.dispose();
    skuController.dispose();
    uomController.dispose();
    super.dispose();
  }

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
                  'Edit Product',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: WHColors.textPrimary,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.of(context).pop(null),
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
              'Update product information below',
              style: TextStyle(fontSize: 12, color: WHColors.grey),
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, color: _borderColor),
            const SizedBox(height: 16),

            // ── Fields ──
            _label('Product Name'),
            TextField(
              controller: nameController,
              style: const TextStyle(fontSize: 13),
              decoration: _inputDecoration('e.g., Indomie Goreng'),
            ),
            const SizedBox(height: 14),

            _label('SKU'),
            TextField(
              controller: skuController,
              style: const TextStyle(fontSize: 13),
              decoration: _inputDecoration('e.g., IND-001'),
            ),
            const SizedBox(height: 14),

            _label('Unit of Measure'),
            TextField(
              controller: uomController,
              style: const TextStyle(fontSize: 13),
              decoration: _inputDecoration('e.g., Pcs, Kg, Box'),
            ),

            const SizedBox(height: 20),

            // ── Actions ──
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(null),
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
                    onPressed: () => Navigator.of(context).pop(
                      ProductEditResult(
                        productName: nameController.text.trim(),
                        sku: skuController.text.trim(),
                        unitOfMeasure: uomController.text.trim(),
                      ),
                    ),
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
