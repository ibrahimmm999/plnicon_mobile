// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/rack_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddRackPage extends StatefulWidget {
  const AddRackPage({super.key, required this.pm});
  final PmModel pm;

  @override
  State<AddRackPage> createState() => _AddRackPageState();
}

String tglInstalasi = "";

class _AddRackPageState extends State<AddRackPage> {
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController nomorRack = TextEditingController();
    TextEditingController lokasi = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Rack"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Nomor Rack",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(
            controller: nomorRack,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Lokasi",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: lokasi),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tanggal Instalasi",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    cancelText: "Cancel",
                    confirmText: "Set",
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1945),
                    lastDate: DateTime.now());
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                  setState(() {
                    tglInstalasi = formattedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(defaultMargin),
                decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(defaultRadius)),
                child: Row(
                  children: [
                    Text(
                      tglInstalasi.isEmpty
                          ? DateFormat('yyyy-MM-dd hh:mm:ss')
                              .format(DateTime.now())
                          : tglInstalasi,
                      style: buttonText,
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 52,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                if (lokasi.text.isNotEmpty && nomorRack.text.isNotEmpty) {
                  await RackMasterService().postRackMaster(
                      popId: widget.pm.popId,
                      lokasi: lokasi.text,
                      nomorRack: int.parse(nomorRack.text),
                      tglInstalasi: tglInstalasi);
                  popProvider.getDataPop(id: widget.pm.popId);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primaryRed,
                      content: const Text(
                        'Isi data dengan lengkap',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: primaryGreen,
              clickColor: clickGreen),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
