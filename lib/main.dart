import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/login_page.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/pages/splash_page.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'providers/page_provider.dart';
import 'providers/images_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => ImagesProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const MainPage(),
          '/log-in': (context) => const LoginPage(),
        },
      ),
    );
  }
}
