import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/login_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  getinit() async {
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_text.png'),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                  color: primaryBlue, borderRadius: BorderRadius.circular(32)),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "New SiPreman",
              style: header1.copyWith(color: primaryBlue),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Sistem Informasi Preventive Maintenance",
              style: header3.copyWith(color: primaryBlue, fontWeight: regular),
              textAlign: TextAlign.center,
            ),
          ],
        )),
      ),
    );
  }
}
