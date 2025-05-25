import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/color.dart';
import 'package:get/get.dart';

AppBar AppBarWidget(){
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.secondaryColor,
    centerTitle: true,
    title: Text(
        "NoteX",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
          fontFamily: GoogleFonts.overpass().fontFamily,
        )
    ),
    actions: [
      GestureDetector(
        onTap: (){
          Get.toNamed('/search');
        },
        child: FaIcon(
          FontAwesomeIcons.search,
          color: AppColors.textColor,
        ),
      ),
      SizedBox(width: 25,)
    ],
  );
}
