// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/pop_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/modul_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddModulPage extends StatelessWidget {
  const AddModulPage({super.key, required this.pop});
  final PopModel pop;

  @override
  Widget build(BuildContext context) {
    String rectId = "";
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController snController = TextEditingController();
    TextEditingController kapasitasController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Modul"),
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
                    print(value);
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
                        await ModulMasterService().postModulMaster(
                          sn: snController.text,
                          kapasitas: int.parse(kapasitasController.text),
                          rectId: int.parse(rectId),
                        );
                        popProvider.getDataPop(id: pop.id);
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
