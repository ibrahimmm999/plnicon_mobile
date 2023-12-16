// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/mcb_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/mcb_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditMcbPage extends StatefulWidget {
  const EditMcbPage({super.key, required this.pm, required this.mcb});
  final PmModel pm;
  final McbMasterModel mcb;

  @override
  State<EditMcbPage> createState() => _EditMcbPageState();
}

String tglInstalasi = '';
String pdbId = '';
String tipe = '';

class _EditMcbPageState extends State<EditMcbPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      pdbId = widget.mcb.pdbId.toString();
      tipe = widget.mcb.tipe;
      tglInstalasi = widget.mcb.tanggalInstalasi;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listTipe = ['AC', 'DC'];
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController namaController =
        TextEditingController(text: widget.mcb.nama);
    TextEditingController jumlahPhasaController =
        TextEditingController(text: widget.mcb.phasa);
    TextEditingController merkController =
        TextEditingController(text: widget.mcb.merk);
    TextEditingController kapasitasController =
        TextEditingController(text: widget.mcb.kapasitas);
    TextEditingController aTerukurController =
        TextEditingController(text: widget.mcb.aTerukur);
    TextEditingController peruntukanController =
        TextEditingController(text: widget.mcb.peruntukan ?? "");
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add MCB"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Pdb",
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
            items: popProvider.listPop.first.listPdb
                .map((e) => DropdownMenuItem(
                      value: e.id.toString(),
                      child: Text(
                        '${e.id.toString()} - ${e.nama}',
                      ),
                    ))
                .toList(),
            value: pdbId.isEmpty ? null : pdbId,
            onChanged: (value) {
              pdbId = value.toString();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Nama",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: namaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Phasa",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: jumlahPhasaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kapasitas",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: kapasitasController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "A Terukur",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: aTerukurController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Peruntukan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: peruntukanController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tipe",
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
            items: listTipe
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: tipe.isEmpty ? null : tipe,
            onChanged: (value) {
              tipe = value.toString();
            },
          ),
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
                    initialDate: DateTime.parse(tglInstalasi),
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
                      tglInstalasi,
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
                if (namaController.text.isNotEmpty &&
                    jumlahPhasaController.text.isNotEmpty &&
                    merkController.text.isNotEmpty &&
                    kapasitasController.text.isNotEmpty &&
                    aTerukurController.text.isNotEmpty &&
                    tipe.isNotEmpty &&
                    pdbId.isNotEmpty) {
                  await McbMasterService().editMcbMaster(
                    mcbId: widget.mcb.id,
                    aTerukur: aTerukurController.text,
                    peruntukan: peruntukanController.text,
                    tipe: tipe,
                    pdbId: int.parse(pdbId),
                    nama: namaController.text,
                    tglInstalasi: tglInstalasi,
                    merk: merkController.text,
                    kapasitas: kapasitasController.text,
                    jumlahPhasa: jumlahPhasaController.text,
                    popId: widget.pm.popId,
                  );
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PmDetailPage(pm: widget.pm)),
                      (route) => false);
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
