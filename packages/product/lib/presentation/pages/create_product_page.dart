import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product/presentation/bloc/product_bloc.dart';
import 'package:product/presentation/bloc/product_event.dart';
import 'package:product/presentation/bloc/product_state.dart';
import 'package:product/presentation/pages/barcode_scanner_page.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _skuController = TextEditingController();
  final _productNameController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _unitOfMeasureController = TextEditingController();

  static const _primaryOrange = WHColors.secondary3;
  static const _borderColor = WHColors.grey;
  static const _hintColor = WHColors.grey;

  @override
  void dispose() {
    _skuController.dispose();
    _productNameController.dispose();
    _barcodeController.dispose();
    _unitOfMeasureController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<ProductBloc>().add(
      CreateProductEvent(
        sku: _skuController.text.trim(),
        productName: _productNameController.text.trim(),
        barcode: _barcodeController.text.trim(),
        unitOfMeasure: _unitOfMeasureController.text.trim(),
      ),
    );
  }

  void _openScanner() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
    );

    if (result != null) {
      setState(() {
        _barcodeController.text = result;
      });
    }
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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 13),
          decoration: _inputDecoration(hint).copyWith(suffixIcon: suffixIcon),
          validator: validator,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductLoaded) {
          Navigator.of(context).pop(true);
        } else if (state is ProductError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
        }
      },
      child: Scaffold(
        backgroundColor: WHColors.background,
        appBar: WHAppbar(title: 'Add Product'),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildField(
                        label: 'SKU',
                        controller: _skuController,
                        hint: 'e.g., LTP-ASUS-001',
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'SKU required'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildField(
                        label: 'Product Name',
                        controller: _productNameController,
                        hint: 'e.g., ASUS Laptop',
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'Product name required'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildField(
                        label: 'Barcode',
                        controller: _barcodeController,
                        hint: 'e.g., 8991234567890',
                        // Tambahkan parameter suffixIcon pada _buildField Anda atau modifikasi manual:
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            color: _primaryOrange,
                          ),
                          onPressed: _openScanner,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildField(
                        label: 'Unit of Measure',
                        controller: _unitOfMeasureController,
                        hint: 'e.g., PCS',
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'Unit of measure required'
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(
                    Icons.check_circle_outline,
                    size: 17,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Save Product',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
