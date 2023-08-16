import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class HasilUkurPage extends StatelessWidget {
  const HasilUkurPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget card(String title, Function() ontap) {
      return GestureDetector(
        onTap: ontap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: neutral500,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(52, 0, 0, 0),
                    offset: Offset(0, 4),
                    blurRadius: 4)
              ],
              borderRadius: BorderRadius.circular(defaultRadius)),
          width: double.infinity,
          height: 60,
          child: Center(
              child: Text(
            title,
            style: buttonText.copyWith(color: textDarkColor),
          )),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            "Rekap Hasil",
            style: header3,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }

    return Scaffold(
      body: content(),
    );
  }
}
