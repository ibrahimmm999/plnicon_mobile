import 'package:flutter/material.dart';

class DataTeknisPage extends StatelessWidget {
  const DataTeknisPage({super.key, required this.pageName});
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Data Teknis")),
    );
  }
}
