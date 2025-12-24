import 'package:flutter/material.dart' hide DrawerController;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/PageViewController.dart';

AppBar AppBarWidget(BuildContext context){
  final PageViewController pageViewController = Get.find();
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.primary,
    centerTitle: true,
    leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
    ),
    title: Text(
        "NoteX",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          fontFamily: GoogleFonts.overpass().fontFamily,
        )
    ),
    actions: [
      GestureDetector(
        onTap: () => pageViewController.goToPage(1),
        child: FaIcon(
          FontAwesomeIcons.search,
        ),
      ),
      SizedBox(width: 25,)
    ],
  );
}
