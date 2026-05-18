import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone/presentation/bloc/zone_bloc.dart';
import 'package:zone/presentation/bloc/zone_event.dart';
import 'package:zone/presentation/bloc/zone_state.dart';

class CreateZonePage extends StatefulWidget {
  const CreateZonePage({super.key});

  @override
  State<CreateZonePage> createState() => _CreateZonePageState();
}

class _CreateZonePageState extends State<CreateZonePage> {
  final _formKey = GlobalKey<FormState>();
  final _zoneNameController = TextEditingController();
  final _zoneCodeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _totalAisleController = TextEditingController();
  final _shelfPerAisleController = TextEditingController();
  final _capacityPerShelfController = TextEditingController();

  /// Guard mencegah double-submit saat menunggu respons bloc.
  bool _isSubmitting = false;

  static const _primaryOrange = Color(0xFFD94F1E);
  static const _borderColor = Color(0xFFDDDDDD);
  static const _hintColor = WHColors.grey;

  @override
  void dispose() {
    _zoneNameController.dispose();
    _zoneCodeController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _totalAisleController.dispose();
    _shelfPerAisleController.dispose();
    _capacityPerShelfController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_isSubmitting) return; // cegah double-tap
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final totalAisle = int.tryParse(_totalAisleController.text) ?? 0;
    final shelfPerAisle = int.tryParse(_shelfPerAisleController.text) ?? 0;
    final capacityPerShelf =
        int.tryParse(_capacityPerShelfController.text) ?? 0;
    context.read<ZoneBloc>().add(
      CreateZoneEvent(
        zoneName: _zoneNameController.text.trim(),
        zoneCode: _zoneCodeController.text.trim(),
        category: _categoryController.text.trim(),
        totalAisle: totalAisle,
        shelfPerAisle: shelfPerAisle,
        capacityPerShelf: capacityPerShelf,
        description: _descriptionController.text.trim(),
      ),
    );
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

  Widget _numericInput(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(child: _label(label)),
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
                int val = int.tryParse(controller.text) ?? 0;
                controller.text = (val - 1).clamp(0, 999999).toString();
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
                child: TextFormField(
                  controller: controller,
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
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    if (int.tryParse(v) == null) return 'Invalid number';
                    return null;
                  },
                ),
              ),
              _stepperButton('+', () {
                int val = int.tryParse(controller.text) ?? 0;
                controller.text = (val + 1).toString();
              }),
            ],
          ),
        ),
      ],
    );
  }

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

  @override
  Widget build(BuildContext context) {
    // BlocConsumer: listener untuk navigasi & snackbar,
    //               builder untuk disable tombol saat loading.
    return BlocConsumer<ZoneBloc, ZoneState>(
      listener: (context, state) {
        if (state is ZoneOperationSuccess) {
          // Tampilkan pesan sukses di ZoneListPage via ScaffoldMessenger app-level,
          // lalu pop kembali. ZoneListPage.didPopNext() akan refresh list-nya.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Zone saved successfully!',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
              ),
            );
          Navigator.of(context).pop(true);
        } else if (state is ZoneError) {
          // Reset flag agar user bisa coba lagi setelah error.
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ZoneLoading || _isSubmitting;

        return Scaffold(
          backgroundColor: WHColors.background,
          appBar: WHAppbar(title: 'Add Zone'),
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
                        _label('Zone Code'),
                        TextFormField(
                          controller: _zoneCodeController,
                          style: const TextStyle(fontSize: 13),
                          decoration: _inputDecoration('e.g., ELC'),
                        ),
                        const SizedBox(height: 16),

                        _label('Zone Name'),
                        TextFormField(
                          controller: _zoneNameController,
                          style: const TextStyle(fontSize: 13),
                          decoration: _inputDecoration('e.g., Electronic'),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Zone name required'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        _label('Zone Category'),
                        TextFormField(
                          controller: _categoryController,
                          style: const TextStyle(fontSize: 13),
                          decoration: _inputDecoration('e.g., Electronic'),
                        ),
                        const SizedBox(height: 16),

                        _numericInput('Total Aisle', _totalAisleController),
                        const SizedBox(height: 16),

                        _numericInput(
                          'Shelf Per Aisle',
                          _shelfPerAisleController,
                        ),
                        const SizedBox(height: 16),

                        _numericInput(
                          'Capacity Per Shelf',
                          _capacityPerShelfController,
                        ),
                        const SizedBox(height: 16),

                        _label('Description'),
                        Stack(
                          children: [
                            TextFormField(
                              controller: _descriptionController,
                              style: const TextStyle(fontSize: 13),
                              decoration: _inputDecoration(
                                'Add description here ....',
                              ),
                              maxLines: 4,
                            ),
                            const Positioned(
                              right: 10,
                              top: 10,
                              child: Text(
                                '(Optional)',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFB0B0B0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Tombol fixed di bawah — disabled & tunjukkan spinner saat loading
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _submit,
                    icon: isLoading
                        ? const SizedBox(
                            width: 17,
                            height: 17,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.check_circle_outline,
                            size: 17,
                            color: Colors.white,
                          ),
                    label: Text(
                      isLoading ? 'Saving...' : 'Save Zone',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoading
                          ? _primaryOrange.withOpacity(0.6)
                          : _primaryOrange,
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
        );
      },
    );
  }
}