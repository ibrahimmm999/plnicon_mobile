import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class CustomButtonLoading extends StatelessWidget {
  const CustomButtonLoading({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: neutral50,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Loading...",
              style: buttonText.copyWith(),
            ),
          ],
        ));
  }
}
