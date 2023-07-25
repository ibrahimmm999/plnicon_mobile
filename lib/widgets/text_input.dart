import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {super.key,
      required this.controller,
      required this.placeholder,
      required this.isPassword});
  final TextEditingController controller;
  final String placeholder;
  final bool isPassword;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? isObscure : false,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: Visibility(
            visible: widget.isPassword,
            child: InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child:
                    Icon(isObscure ? Icons.visibility : Icons.visibility_off))),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        hintText: widget.placeholder,
        hintStyle: body.copyWith(fontWeight: semibold, color: neutral600),
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
    );
  }
}
