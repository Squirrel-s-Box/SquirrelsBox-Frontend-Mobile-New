import 'package:flutter/material.dart';

import '../../../config/theme/colors.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final bool logging;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double textSize;

  const AppButton({
    super.key,
    this.color = AppColors.darkBrown,
    required this.logging,
    required this.onPressed,
    required this.text,
    this.textColor = AppColors.white,
    this.textSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: logging ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: color, // Darker shade
        ),
        child: logging
            ? const CircularProgressIndicator()
            : Text(
          text,
          style: TextStyle(color: textColor, fontSize: textSize),
        ),
      ),
    );
  }
}