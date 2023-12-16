// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/env_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddEnvPage extends StatefulWidget {
  const AddEnvPage({super.key, required this.pm});
  final PmModel pm;

  @override
  State<AddEnvPage> createState() => _AddEnvPageState();
}

String tglInstalasi = '';

class _AddEnvPageState extends State<AddEnvPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    });
  }

  String bangunan = "";
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    List<String> listBangunan = ["Ok", "Not OK"];
    TextEditingController exhaustController = TextEditingController();
    TextEditingController jumlahLampuController = TextEditingController();
    TextEditingController lampuController = TextEditingController();
    TextEditingController kebersihanBangunanController =
        TextEditingController();
    TextEditingController kebersihanExhaustController = TextEditingController();
    TextEditingController suhuRuanganController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Environment"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Bangunan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          DropdownButtonFormField(
            alignment: Alignment.centerLeft,
            style: buttonText.copyWith(color: textDarkColor),
            borderRadius: BorderRadius.circular(defaultRadius),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defaultRadius),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(width: 2, color: primaryBlue),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(width: 2, color: neutral500),
              ),
              hintStyle: buttonText.copyWith(color: textDarkColor),
            ),
            items: listBangunan
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: bangunan.isEmpty ? null : bangunan,
            onChanged: (value) {
              bangunan = value.toString();
              // setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Exhaust",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: exhaustController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Jumlah Lampu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(
              controller: jumlahLampuController,
              keyboardType: TextInputType.number),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Jumlah Lampu Menyala",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(
              controller: lampuController, keyboardType: TextInputType.number),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Keberihan Bangunan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: kebersihanBangunanController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kebersihan Exhaust",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: kebersihanExhaustController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Suhu Ruangan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(
              controller: suhuRuanganController,
              keyboardType: TextInputType.number),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                if (exhaustController.text.isNotEmpty &&
                    kebersihanExhaustController.text.isNotEmpty &&
                    lampuController.text.isNotEmpty &&
                    jumlahLampuController.text.isNotEmpty &&
                    suhuRuanganController.text.isNotEmpty &&
                    bangunan.isNotEmpty &&
                    kebersihanBangunanController.text.isNotEmpty) {
                  await EnvironmentMasterService().postEnvMaster(
                      pmId: widget.pm.id,
                      popId: widget.pm.popId,
                      exhaust: exhaustController.text,
                      lampu: lampuController.text,
                      jumlahLampu: jumlahLampuController.text,
                      kebersihanBangunan: kebersihanBangunanController.text,
                      bangunan: bangunan,
                      suhuRuangan: double.parse(suhuRuanganController.text),
                      kebersihanExhaust: kebersihanBangunanController.text,
                      tglInstalasi: tglInstalasi);
                  await popProvider.getDataPop(id: widget.pm.popId);
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
          )
        ],
      ),
    );
  }
}
