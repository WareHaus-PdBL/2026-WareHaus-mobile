import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class StockEditResult {
  const StockEditResult({
    required this.quantity,
  });

  final int quantity;
}

Future<StockEditResult?> showStockEditDialog(
  BuildContext context, {
  required int initialQuantity,
  required String shelfCode,
}) async {
  return showDialog<StockEditResult>(
    context: context,
    builder: (ctx) => _StockEditDialog(
      initialQuantity: initialQuantity,
      shelfCode: shelfCode,
    ),
  );
}

class _StockEditDialog extends StatefulWidget {
  const _StockEditDialog({
    required this.initialQuantity,
    required this.shelfCode,
  });

  final int initialQuantity;
  final String shelfCode;

  @override
  State<_StockEditDialog> createState() => _StockEditDialogState();
}

class _StockEditDialogState extends State<_StockEditDialog> {
  late final TextEditingController quantityController;

  static const _primaryOrange = WHColors.secondary3;
  static const _borderColor = WHColors.grey;
  static const _hintColor = WHColors.grey;

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController(
      text: widget.initialQuantity.toString(),
    );
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: _hintColor, fontSize: 13),
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
      borderSide: BorderSide(color: _hintColor, width: 1.5),
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

  Widget _stepperButton(String label, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 36,
      height: 38,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, color: Color(0xFF555555)),
        ),
      ),
    ),
  );

  Widget _numericInput() {
    return Row(
      children: [
        Expanded(child: _label('Quantity')),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: 1.5),
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _stepperButton('−', () {
                final current = int.tryParse(quantityController.text) ?? 0;
                quantityController.text =
                    (current - 1).clamp(0, 999999).toString();
              }),
              Container(
                width: 80,
                height: 38,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(color: _borderColor),
                  ),
                ),
                child: TextField(
                  controller: quantityController,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                  ),
                ),
              ),
              _stepperButton('+', () {
                final current = int.tryParse(quantityController.text) ?? 0;
                quantityController.text = (current + 1).toString();
              }),
            ],
          ),
        ),
      ],
    );
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
                  'Edit Stock',
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
            Text(
              'Shelf: ${widget.shelfCode}',
              style: const TextStyle(fontSize: 12, color: WHColors.grey),
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, color: _borderColor),
            const SizedBox(height: 16),

            // ── Quantity Field ──
            _numericInput(),

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
                    onPressed: () {
                      final quantity = int.tryParse(quantityController.text);
                      if (quantity == null || quantity < 0) return;
                      Navigator.of(context).pop(
                        StockEditResult(quantity: quantity),
                      );
                    },
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