// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/modul_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/modul_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditModulPage extends StatelessWidget {
  const EditModulPage({super.key, required this.pm, required this.modul});
  final PmModel pm;
  final ModulMasterModel modul;
  @override
  Widget build(BuildContext context) {
    String rectId = modul.rectId.toString();
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController snController = TextEditingController(text: modul.sn);
    TextEditingController kapasitasController =
        TextEditingController(text: modul.kapasitas.toString());
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Edit Modul"),
      body: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: CircularProgressIndicator(
                  color: primaryBlue,
                )),
              ],
            )
          : ListView(
              padding: EdgeInsets.all(defaultMargin),
              children: [
                Text(
                  "Rectifier",
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
                  items: popProvider.listPop.first.listRect
                      .map((e) => DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(
                              '${e.id.toString()} - ${e.merk}',
                            ),
                          ))
                      .toList(),
                  value: rectId.isEmpty ? null : rectId,
                  onChanged: (value) {
                    rectId = value.toString();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Sn",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                TextInput(controller: snController),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Kapasitas",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                TextInput(
                    controller: kapasitasController,
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
                      if (snController.text.isNotEmpty &&
                          kapasitasController.text.isNotEmpty &&
                          rectId.isNotEmpty) {
                        await ModulMasterService().editModulMaster(
                          modulId: modul.id,
                          sn: snController.text,
                          kapasitas: int.parse(kapasitasController.text),
                          rectId: int.parse(rectId),
                        );
                        await popProvider.getDataPop(id: pm.popId);
                        Navigator.pop(context);
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
