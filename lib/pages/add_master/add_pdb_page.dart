import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/ac_master_service.dart';
import 'package:plnicon_mobile/services/master/pdb_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddPdbPage extends StatefulWidget {
  const AddPdbPage({super.key, required this.popId});
  final int popId;

  @override
  State<AddPdbPage> createState() => _AddPdbPageState();
}

String tglInstalasi = '';

class _AddPdbPageState extends State<AddPdbPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController namaAcController = TextEditingController();
    TextEditingController tipeController = TextEditingController();
    TextEditingController aresterController = TextEditingController();
    TextEditingController aresterTipeController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Pdb"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Nama",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: namaAcController),
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
            "Arester",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: aresterController),
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
                await PdbMasterService().postPdbMaster(
                  nama: namaAcController.text,
                  tipe: tipeController.text,
                  arester: aresterController.text,
                  aresterTipe: aresterTipeController.text,
                  popId: widget.popId,
                );
                popProvider.getDataPop(id: widget.popId);
                Navigator.pop(context);
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
