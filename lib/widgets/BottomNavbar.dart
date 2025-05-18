import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/utils/color.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: AppColors.secondaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
              icon:FaIcon(
                  FontAwesomeIcons.home,
                  size: 23,
              ),
              label: "Home"
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
              icon:FaIcon(
                FontAwesomeIcons.plus,
                size: 23,
              ),
              label: "Home"
          ),
        ]
    );
  }
}
