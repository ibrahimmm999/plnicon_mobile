import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class InputDokumentasi extends StatelessWidget {
  const InputDokumentasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dokumentasi",
          style: buttonText.copyWith(color: textDarkColor),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(defaultMargin),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tambahkan dokumentasi",
                  style: buttonText,
                ),
                Icon(
                  Icons.play_arrow_sharp,
                  color: textLightColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
