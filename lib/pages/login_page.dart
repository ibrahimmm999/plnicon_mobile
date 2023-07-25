import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/home_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: neutral100,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
              child: Image.asset(
                'assets/logo_text.png',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              decoration: BoxDecoration(
                  color: textLightColor,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: header1.copyWith(color: primaryBlue),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  TextInput(
                    controller: usernameController,
                    isPassword: false,
                    placeholder: "Username...",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextInput(
                    controller: passwordController,
                    isPassword: true,
                    placeholder: "Password...",
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      color: primaryBlue,
                      clickColor: clickBlue)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
