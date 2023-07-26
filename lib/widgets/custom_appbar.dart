import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title = "", this.isMainPage = true});
  final String title;
  final bool isMainPage;

  @override
  Widget build(BuildContext context) {
    return isMainPage
        ? AppBar(
            leadingWidth: double.infinity,
            leading: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/logo.png"),
                    Text(
                      "Icon Plus",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, color: textDarkColor),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(360),
                      child: const Icon(
                        Icons.notifications,
                        size: 28,
                      ),
                    )
                  ]),
            ),
          )
        : AppBar(
            title: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 60),
                child: Text(
                  title,
                  style: header2.copyWith(color: textLightColor),
                ),
              ),
            ),
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
