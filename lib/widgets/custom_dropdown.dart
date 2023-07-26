import 'package:flutter/material.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.list, this.placeholder = "-"});
  final List list;
  final String placeholder;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    String? selectedItem;
    return DropdownButtonFormField(
      alignment: Alignment.centerLeft,
      style: buttonText.copyWith(color: textDarkColor),
      borderRadius: BorderRadius.circular(defaultRadius),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(defaultRadius),
        hintText: widget.placeholder,
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
      items: widget.list
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                ),
              ))
          .toList(),
      value: selectedItem,
      onChanged: (value) {
        selectedItem = value.toString();
      },
    );
  }
}
