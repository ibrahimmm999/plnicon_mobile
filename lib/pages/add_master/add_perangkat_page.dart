// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/perangkat_service_master.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddPerangkatPage extends StatefulWidget {
  const AddPerangkatPage({super.key, required this.popId});
  final int popId;

  @override
  State<AddPerangkatPage> createState() => _AddPerangkatPageState();
}

String tglInstalasi = '';

class _AddPerangkatPageState extends State<AddPerangkatPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    String rackId = '';
    String jenis = '';
    String sumberMain = '';
    String sumberBackup = '';
    List<String> listSumberMain = ['AC', 'DC'];
    List<String> listSumberBackup = ['AC', 'DC', 'TIADA'];
    List<String> listJenis = ['AKTIF', 'ODF'];
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController namaController = TextEditingController();
    TextEditingController terminasiController = TextEditingController();
    TextEditingController merkController = TextEditingController();
    TextEditingController tipeController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Perangkat"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Rack",
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
            items: popProvider.listPop.first.listRack
                .map((e) => DropdownMenuItem(
                      value: e.id.toString(),
                      child: Text(
                        'id : ${e.id} - Nomor Rack: ${e.nomorRack}',
                      ),
                    ))
                .toList(),
            value: rackId.isEmpty ? null : rackId,
            onChanged: (value) {
              rackId = value.toString();
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
            "Terminasi",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: terminasiController),
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
            "Tipe",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: tipeController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Jenis",
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
            items: listJenis
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: jenis.isEmpty ? null : jenis,
            onChanged: (value) {
              jenis = value.toString();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Sumber Main",
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
            items: listSumberMain
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: sumberMain.isEmpty ? null : sumberMain,
            onChanged: (value) {
              sumberMain = value.toString();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Sumber Backup",
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
            items: listSumberBackup
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: sumberBackup.isEmpty ? null : sumberBackup,
            onChanged: (value) {
              sumberBackup = value.toString();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // Text(
          //   "Tanggal Instalasi",
          //   style: buttonText.copyWith(color: textDarkColor),
          // ),
          // GestureDetector(
          //     onTap: () async {
          //       DateTime? pickedDate = await showDatePicker(
          //           context: context,
          //           cancelText: "Cancel",
          //           currentDate: DateTime.now(),
          //           confirmText: "Set",
          //           initialDate: DateTime.now(),
          //           firstDate: DateTime(1945),
          //           lastDate: DateTime.now());
          //       if (pickedDate != null) {
          //         String formattedDate =
          //             DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
          //         setState(() {
          //           tglInstalasi = formattedDate;
          //         });
          //       }
          //     },
          //     child: Container(
          //       padding: EdgeInsets.all(defaultMargin),
          //       decoration: BoxDecoration(
          //           color: primaryBlue,
          //           borderRadius: BorderRadius.circular(defaultRadius)),
          //       child: Row(
          //         children: [
          //           Text(
          //             tglInstalasi,
          //             style: buttonText,
          //           )
          //         ],
          //       ),
          //     )),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                if (namaController.text.isNotEmpty &&
                    terminasiController.text.isNotEmpty &&
                    merkController.text.isNotEmpty &&
                    tipeController.text.isNotEmpty &&
                    sumberBackup.isNotEmpty &&
                    sumberMain.isNotEmpty &&
                    jenis.isNotEmpty &&
                    rackId.isNotEmpty) {
                  await PerangkatMasterService().postPerangkatMaster(
                      tipe: tipeController.text,
                      rackId: int.parse(rackId),
                      nama: namaController.text,
                      tglInstalasi: tglInstalasi,
                      merk: merkController.text,
                      jenis: jenis,
                      sumberBackup: sumberBackup,
                      sumberMain: sumberMain,
                      terminasi: terminasiController.text);
                  popProvider.getDataPop(id: widget.popId);
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
