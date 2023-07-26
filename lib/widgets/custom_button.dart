import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.clickColor});
  final String text;
  final Color color;
  final Color clickColor;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: color,
            foregroundColor: clickColor,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
        child: Text(
          text,
          style: buttonText.copyWith(),
        ),
      ),
    );
  }
}
