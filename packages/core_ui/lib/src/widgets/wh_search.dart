import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class WHSearch extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  const WHSearch({
    super.key,
    this.hintText = "Search...",
    this.controller,
    this.onChanged,
  }); // Default hint text

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 3, color: WHColors.grey5),
        ),
        filled: true,
        fillColor: WHColors.surface,
      ),
      onChanged: onChanged,
    );
  }
}
