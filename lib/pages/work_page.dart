import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/pm_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/workorder_card.dart';
import 'package:provider/provider.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    PmProvider pmProvider = Provider.of<PmProvider>(context);
    Widget switchContent() {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 52,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomePageNav(
                title: 'Work',
                index: 0,
                width: MediaQuery.sizeOf(context).width * 0.5),
            HomePageNav(
                title: 'Completed',
                index: 1,
                width: MediaQuery.sizeOf(context).width * 0.5),
          ],
        ),
      );
    }

    Widget content() {
      int indexHome = pageProvider.homePage;
      switch (indexHome) {
        case 0:
          return Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 200),
              children: pmProvider.listPm
                  .where((element) => element.status == "PLAN")
                  .map((pm) {
                return WorkOrderCard(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PmDetailPage(
                                  pm: pm,
                                )));
                  },
                  nama: pm.pop.nama,
                  popKode: pm.pop.popKode,
                  tanggal: pm.plan.toString(),
                  detail: pm.detailPm,
                );
              }).toList(),
            ),
          );
        case 1:
          return Expanded(
            child: ListView(
              children: pmProvider.listPm
                  .where((element) => element.status == "REALISASI")
                  .map((pm) {
                return WorkOrderCard(
                  onTap: () {},
                  nama: pm.pop.nama,
                  popKode: pm.pop.popKode,
                  tanggal: pm.plan.toString(),
                  detail: pm.detailPm,
                );
              }).toList(),
            ),
          );
        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      body: Column(
        children: [switchContent(), content()],
      ),
    );
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
