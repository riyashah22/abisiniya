import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget CustomAppbarSecondaryScreen(
    BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.white, // Set the back arrow color to white
    ),
    title: Text(
      title,
      style: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        color: CustomColors.lightPrimaryColor,
      ),
    ),
    backgroundColor: CustomColors.primaryColor,
  );
}
//new commit