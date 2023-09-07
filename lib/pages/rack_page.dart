import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/rack_master_model.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/rack_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class RackPage extends StatelessWidget {
  const RackPage({super.key, required this.title, required this.rack});
  final RackMasterModel rack;
  final String title;

  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController nomorRack =
        TextEditingController(text: rack.nomorRack.toString());
    TextEditingController lokasiController =
        TextEditingController(text: rack.lokasi);
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
            "Nomor Rack",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: nomorRack),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Lokasi",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: lokasiController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "List Perangkat : ",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await RackMasterService().editRackMaster(
                    rackId: rack.id,
                    popId: rack.popId,
                    nomorRack: int.parse(nomorRack.text),
                    lokasi: lokasiController.text);
                popProvider.getDataPop(id: rack.popId);
                Navigator.pop(context);
              },
              color: primaryGreen,
              clickColor: clickGreen)
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
