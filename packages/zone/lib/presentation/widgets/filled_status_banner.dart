import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class FilledStatusBanner extends StatelessWidget {
  final bool isFilled;
  const FilledStatusBanner({super.key, this.isFilled = true});

  @override
  Widget build(BuildContext context) {
    final color = isFilled ? WHColors.error3 : WHColors.success3;
    final textColor = isFilled ? WHColors.error2 : WHColors.success2;
    final text = isFilled ? 'Filled Status' : 'Avaible Status';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded, color: textColor, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
