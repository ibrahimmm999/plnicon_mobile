import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_button_loading.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isLoading = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> handleLogin() async {
      setState(() {
        isLoading = true;
      });

      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      if (await userProvider.login(
          username: usernameController.text,
          password: passwordController.text)) {
        pageProvider.setPage = 0;
        navigator.pushNamedAndRemoveUntil('/main', (route) => false);
      } else {
        scaffoldMessenger.removeCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            backgroundColor: primaryRed,
            content: Text(
              userProvider.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

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
                  isLoading
                      ? CustomButtonLoading(color: primaryBlue)
                      : CustomButton(
                          text: "Login",
                          onPressed: handleLogin,
                          color: primaryBlue,
                          clickColor: clickBlue,
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
