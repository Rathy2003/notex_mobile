import 'package:flutter/material.dart' hide DrawerController;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/route/routes.dart';

AppBar AppBarWidget(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: Builder(
      builder:
          (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
    ),
    title: Text(
      "NoteX",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        fontFamily: GoogleFonts.overpass().fontFamily,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.search),
        child: FaIcon(FontAwesomeIcons.search),
      ),
      SizedBox(width: 25),
    ],
  );
}
