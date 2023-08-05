import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class WorkOrderCard extends StatelessWidget {
  const WorkOrderCard({
    super.key,
    required this.onTap,
    required this.nama,
    required this.popKode,
    required this.tanggal,
    required this.detail,
  });
  final Function() onTap;
  final String nama;
  final String popKode;
  final String tanggal;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(30, 0, 0, 0),
                  offset: Offset(0, 4),
                  blurRadius: 4)
            ],
            color: textLightColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: header3,
            ),
            Text(
              popKode,
              style: body,
            ),
            Text(
              tanggal,
              style: body,
            ),
            Text(
              "Requirements: $detail",
              style: body,
            ),
          ],
        ),
      ),
    );
  }
}
