import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/workorder_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    List listpm = ["Rutin", "Incidental", "Improvement"];

    PreferredSizeWidget header() {
      return AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset("assets/logo.png"),
            Text(
              "Icon Plus",
              style: GoogleFonts.montserrat(fontSize: 20, color: textDarkColor),
            ),
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.notifications,
                size: 28,
              ),
            )
          ]),
        ),
      );
    }

    Widget cardPM(String type) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(30, 0, 0, 0),
                  offset: Offset(0, 4),
                  blurRadius: 4)
            ],
            color: textLightColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(360)),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "123 PM Terjadwal",
                  style: body,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: neutral700,
                  size: 52,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style: header3,
                    ),
                    Text(
                      "2 PM Terjadwal",
                      style: body,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    Widget carousel() {
      return Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: defaultMargin),
              child: Text(
                "Halo,",
                style: header2.copyWith(color: primaryBlue),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: defaultMargin, bottom: 18),
              child: Text(
                "Budiman",
                style: header2.copyWith(color: primaryYellow),
              ),
            ),
            CarouselSlider(
                items: listpm
                    .map((e) => Container(
                        margin: const EdgeInsets.only(
                            bottom: 8, left: 12, right: 12),
                        child: cardPM(e)))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayInterval: const Duration(seconds: 10),
                  aspectRatio: 2.6,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listpm.asMap().entries.map((e) {
                return InkWell(
                  radius: 360,
                  onTap: () => _controller.animateToPage(e.key),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(top: 20, left: 6, right: 6),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryBlue
                            .withOpacity(_current == e.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        children: [
          carousel(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Work Order",
                  style: header1.copyWith(color: primaryBlue),
                ),
                const SizedBox(
                  height: 16,
                ),
                WorkOrderCard(),
                WorkOrderCard(),
                WorkOrderCard(),
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header(),
      body: content(),
    );
  }
}
