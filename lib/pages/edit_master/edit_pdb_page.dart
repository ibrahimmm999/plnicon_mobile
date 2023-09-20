import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/pdb_master_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/pdb_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditPdbPage extends StatelessWidget {
  const EditPdbPage({super.key, required this.pdb, required this.title});
  final PdbMasterModel pdb;
  final String title;
  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
        TextEditingController(text: pdb.nama);
    TextEditingController tipeController =
        TextEditingController(text: pdb.tipe);
    TextEditingController aresterController =
        TextEditingController(text: pdb.arester);
    TextEditingController aresterTipeController =
        TextEditingController(text: pdb.aresterTipe);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: title),
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
          Text(
            "Tipe",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: tipeController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tanggal Instalasi : -",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await PdbMasterService().editPdbMaster(
                    pdbId: pdb.id,
                    nama: namaController.text,
                    tipe: tipeController.text,
                    arester: aresterController.text,
                    aresterTipe: aresterTipeController.text,
                    popId: pdb.popId);
                popProvider.getDataPop(id: pdb.popId);
                Navigator.pop(context);
              },
              color: primaryGreen,
              clickColor: clickGreen)
        ],
      ),
    );
  }
}
