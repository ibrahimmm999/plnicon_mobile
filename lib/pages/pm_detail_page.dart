import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/ac_page.dart';
import 'package:plnicon_mobile/pages/baterai_page.dart';
import 'package:plnicon_mobile/pages/kwh_page.dart';
import 'package:plnicon_mobile/pages/recti_page.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class PMDetailPage extends StatelessWidget {
  const PMDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget switchContent() {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 52,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomePageNav(
                title: 'Master',
                index: 0,
                width: MediaQuery.sizeOf(context).width * 0.5),
            HomePageNav(
                title: 'Transactional',
                index: 1,
                width: MediaQuery.sizeOf(context).width * 0.5),
          ],
        ),
      );
    }

    Widget card(String title) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const KWHPage()));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: neutral500,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(52, 0, 0, 0),
                    offset: Offset(0, 4),
                    blurRadius: 4)
              ],
              borderRadius: BorderRadius.circular(defaultRadius)),
          width: double.infinity,
          height: 60,
          child: Center(
              child: Text(
            title,
            style: buttonText.copyWith(color: textDarkColor),
          )),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
          children: [card("AC 1"), card("AC 2")],
        ),
      );
    }

    return Scaffold(
        appBar: const CustomAppBar(isMainPage: false, title: "Nama POP"),
        body: Column(
          children: [switchContent(), content()],
        ));
  }
}

class HomePageNav extends StatelessWidget {
  const HomePageNav({
    Key? key,
    required this.title,
    required this.index,
    required this.width,
  }) : super(key: key);

  final String title;
  final int index;
  final double width;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          pageProvider.setHomePage = index;
        },
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
              ),
              Container(
                margin: const EdgeInsets.only(top: 14),
                height: 3,
                width: width,
                decoration: BoxDecoration(
                  color:
                      pageProvider.homePage == index ? primaryBlue : neutral500,
                  borderRadius: BorderRadius.circular(18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
