import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/pm_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:provider/provider.dart';

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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    PmProvider pmProvider = Provider.of<PmProvider>(context);
    List listpm = ["Rutin", "Incidental", "Improvement"];

    Widget cardPM(String type, int total, int jumlah) {
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
                  "$total PM Terjadwal",
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
                      "$jumlah PM Terjadwal",
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
                userProvider.user.nama,
                style: header2.copyWith(color: primaryYellow),
              ),
            ),
            CarouselSlider(
                items: listpm.map(
                  (tipe) {
                    var hitung = 0;
                    for (var pm in pmProvider.listPm) {
                      if (tipe.toLowerCase() == pm.kategori.toLowerCase()) {
                        hitung++;
                      }
                    }

                    return Container(
                      margin:
                          const EdgeInsets.only(bottom: 8, left: 12, right: 12),
                      child: cardPM(tipe, pmProvider.listPm.length, hitung),
                    );
                  },
                ).toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayInterval: const Duration(seconds: 6),
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
                return GestureDetector(
                  onTap: () => _controller.animateToPage(e.key),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(top: 20, left: 6, right: 6),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryBlue
                            .withOpacity(_current == e.key ? 1 : 0.3)),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      );
    }

    Widget content() {
      int realisasi = 0;
      for (var pm in pmProvider.listPm) {
        if (pm.status == "REALISASI") {
          realisasi++;
        }
      }

      return ListView(
        children: [
          carousel(),
          Padding(
            padding: EdgeInsets.only(
                left: defaultMargin, right: defaultMargin, bottom: 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Summary",
                  style: header1.copyWith(color: primaryBlue),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text("$realisasi dari ${pmProvider.listPm.length} PM Selesai"),
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }
}
