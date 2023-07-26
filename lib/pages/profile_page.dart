import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/login_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Username: AkmalKomeng",
                style: header3,
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 88,
                ),
                child: CustomButton(
                    text: "Log Out",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
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
