import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_button_loading.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool isLoading = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);

    Future<void> handleLogout() async {
      setState(() {
        isLoading = true;
      });

      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      if (await userProvider.logout(token: userProvider.user.token)) {
        navigator.pushNamedAndRemoveUntil('/log-in', (route) => false);
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              const Icon(
                Icons.person_outlined,
                size: 108,
              ),
              const SizedBox(
                height: 48,
              ),
              Text(
                "Username: ${userProvider.user.username}",
                style: header3,
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 88,
                ),
                child: isLoading
                    ? CustomButtonLoading(color: primaryRed)
                    : CustomButton(
                        text: "Log Out",
                        onPressed: handleLogout,
                        color: primaryRed,
                        clickColor: clickRed),
              )
            ],
          ),
        ),
      ),
    );
  }
}
