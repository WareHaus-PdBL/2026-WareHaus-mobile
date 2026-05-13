import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class WHSearch extends StatelessWidget {
  final String hintText;
  const WHSearch({super.key, this.hintText = "Search..."}); // Default hint text

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 3, color: WHColors.grey5),
        ),
        filled: true,
        fillColor: Color(0xFFD8E5E6),
      ),
      onChanged: (value) {
        // Implement search logic if needed
      },
    );
  }
}
