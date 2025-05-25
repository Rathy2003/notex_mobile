import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/AuthController.dart';
import '../route/routes.dart';
import '../utils/color.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthController _authController = Get.find();

    return Container(
      padding: EdgeInsets.only(left: 45, right: 45, top: 15, bottom: 30),
      color: AppColors.secondaryColor,
      child: Row(
        children: [
          GestureDetector(
              onTap: ()=> Get.toNamed(AppRoutes.home),
              child: FaIcon(FontAwesomeIcons.home, color: Get.currentRoute == AppRoutes.home ? Colors.white : Colors.grey)
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff4d4d4d),
            ),
            child: FaIcon(FontAwesomeIcons.plus, color: Colors.white),
          ),
          Spacer(),
          GestureDetector(
            onTap: ()=> Get.toNamed(AppRoutes.profile),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 45,
              width: 45,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "${_authController.user_info.value['avatar']}"
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
