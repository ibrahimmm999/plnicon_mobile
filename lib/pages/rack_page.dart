import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/rack_master_model.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:provider/provider.dart';

class RackPage extends StatelessWidget {
  const RackPage({super.key, required this.title, required this.rack});
  final RackMasterModel rack;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 60),
            child: Text(
              title,
              style: header2.copyWith(color: textLightColor),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Nomor Rack : ${rack.nomorRack}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Lokasi : ${rack.lokasi}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "List Perangkat : ",
            style: buttonText.copyWith(color: textDarkColor),
          ),
        ],
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
          pageProvider.setPmPage = index;
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
                      pageProvider.pmPage == index ? primaryBlue : neutral500,
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
