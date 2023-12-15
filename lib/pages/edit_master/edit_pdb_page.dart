// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/pdb_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/services/master/pdb_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditPdbPage extends StatefulWidget {
  const EditPdbPage(
      {super.key, required this.pdb, required this.title, required this.pm});
  final PdbMasterModel pdb;
  final String title;
  final PmModel pm;

  @override
  State<EditPdbPage> createState() => _EditPdbPageState();
}

String tglInstalasi = "";
String tipe = "";
String arester = "";

class _EditPdbPageState extends State<EditPdbPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = widget.pdb.tanggalInstalasi;
      tipe = widget.pdb.tipe;
      arester = widget.pdb.arester;
    });
  }

  bool loading = true;
  @override
  Widget build(BuildContext context) {
    List<String> listTipe = ["ACPDB", "DCPDB"];
    List<String> listArester = ["ADA", "TIDAK ADA"];
    TransaksionalProvider pdbProvider =
        Provider.of<TransaksionalProvider>(context);
    TextEditingController namaController =
        TextEditingController(text: widget.pdb.nama);
    TextEditingController aresterTipeController =
        TextEditingController(text: widget.pdb.aresterTipe);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: widget.title),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Nama",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: namaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Arester",
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
            items: listArester
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: arester.isEmpty ? null : arester,
            onChanged: (value) {
              arester = value.toString();
              // setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Arester Tipe",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: aresterTipeController),
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
              // setState(() {});
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
                    initialDate: DateTime.parse(widget.pdb.tanggalInstalasi),
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
            height: 20,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await PdbMasterService().editPdbMaster(
                    pdbId: widget.pdb.id,
                    nama: namaController.text,
                    tipe: tipe,
                    arester: arester,
                    aresterTipe: aresterTipeController.text,
                    tglInstalasi: tglInstalasi,
                    popId: widget.pdb.popId);
                await popProvider.getDataPop(id: widget.pdb.popId);
                await pdbProvider.getPdb(widget.pm.id, widget.pdb.id);

                Navigator.pop(context);
                Navigator.pop(context);
              },
              color: primaryGreen,
              clickColor: clickGreen)
        ],
      ),
    );
  }
}
