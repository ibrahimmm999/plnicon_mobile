import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../services/user_service.dart';

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
    final navigator = Navigator.of(context);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final String? token = await UserService().getTokenPreference();

    if (token == null) {
      await navigator.pushNamedAndRemoveUntil('/log-in', (route) => false);
    } else {
      if (await userProvider.getUser(token: token)) {
        await navigator.pushNamedAndRemoveUntil('/main', (route) => false);
      } else {
        await navigator.pushNamedAndRemoveUntil('/log-in', (route) => false);
      }
    }
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
