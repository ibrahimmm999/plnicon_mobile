import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class CustomPopUp extends StatefulWidget {
  final String title;
  final Function() add;
  final TextEditingController controller;
  const CustomPopUp(
      {super.key,
      required this.title,
      required this.add,
      required this.controller});

  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

bool isLoading = false;

class _CustomPopUpState extends State<CustomPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: neutral500,
        actions: [
          Visibility(
            visible: !isLoading,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL', style: buttonText),
            ),
          ),
          Visibility(
            visible: !isLoading,
            child: TextButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final navigator = Navigator.of(context);
                await widget.add();
                navigator.pop(true);
                setState(() {
                  isLoading = false;
                });
              },
              child: Text('SAVE', style: buttonText),
            ),
          )
        ],
        title: Visibility(
          visible: !isLoading,
          child: Text(widget.title, style: buttonText),
        ),
        content: isLoading
            ? SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: textLightColor,
                    size: 32,
                  ),
                ),
              )
            : TextInput(
                controller: widget.controller,
                isLongText: true,
                label: "Deskripsi",
                placeholder: "Deskripsi",
              ));
  }
}
