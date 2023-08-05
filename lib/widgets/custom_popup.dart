import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plnicon_mobile/theme/theme.dart';

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
      backgroundColor: textLightColor,
      actions: [
        Visibility(
          visible: !isLoading,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL',
                style: buttonText.copyWith(color: textDarkColor)),
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
            child:
                Text('SAVE', style: buttonText.copyWith(color: textDarkColor)),
          ),
        )
      ],
      title: Visibility(
        visible: !isLoading,
        child: Text(widget.title,
            style: buttonText.copyWith(color: textDarkColor)),
      ),
      content: isLoading
          ? SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: textDarkColor,
                  size: 32,
                ),
              ),
            )
          : TextFormField(
              maxLines: 8,
              style: GoogleFonts.montserrat(
                  color: textDarkColor, fontSize: 16, fontWeight: medium),
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                hintText: widget.title,
                hintStyle:
                    body.copyWith(fontWeight: semibold, color: neutral600),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(color: primaryBlue, width: 2)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(
                    color: neutral500,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
    );
  }
}
