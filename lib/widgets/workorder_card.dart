import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class WorkOrderCard extends StatelessWidget {
  const WorkOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "POP Cawang GI Shelter",
            style: header3,
          ),
          Text(
            "1234567",
            style: body,
          ),
          Text(
            "dd-mm-yyyy",
            style: body,
          ),
          Text(
            "Requirements: AC, Recti",
            style: body,
          ),
        ],
      ),
    );
  }
}
