import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/home_page.dart';
import 'package:plnicon_mobile/pages/profile_page.dart';
import 'package:plnicon_mobile/pages/work_page.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget buildContent() {
      int newPage = pageProvider.page;
      switch (newPage) {
        case 0:
          {
            return const HomePage();
          }
        case 1:
          {
            return const WorkPage();
          }
        case 2:
          {
            return const ProfilePage();
          }

        default:
          {
            return const HomePage();
          }
      }
    }

    Widget customBottomNavigationUser() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Color.fromARGB(35, 0, 0, 0),
              blurRadius: 4,
              offset: Offset(0, -4))
        ]),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationItem(
              icon: Icons.home_outlined,
              label: 'Home',
              index: 0,
            ),
            NavigationItem(
              icon: Icons.assignment_outlined,
              label: 'Work',
              index: 1,
            ),
            NavigationItem(
              icon: Icons.person_outlined,
              label: 'Profile',
              index: 2,
            ),
          ],
        ),
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(isMainPage: true),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            buildContent(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [customBottomNavigationUser()],
            ),
          ],
        ));
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    required this.icon,
    required this.label,
    required this.index,
    Key? key,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    return GestureDetector(
      onTap: () {
        pageProvider.setPage = index;
        if (index == 0) {
          pageProvider.setHomePage = 0;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 32,
              color: pageProvider.page == index ? primaryBlue : neutral500),
          Text(label,
              style: pageProvider.page == index
                  ? buttonText.copyWith(color: primaryBlue)
                  : buttonText.copyWith(color: neutral500)),
        ],
      ),
    );
  }
}
