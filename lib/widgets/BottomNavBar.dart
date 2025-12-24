import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/PageViewController.dart';
import 'package:notex_mobile/utils/color.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final PageViewController pageViewController = Get.find();

    return Container(
      padding: EdgeInsets.only(left: 45, right: 45, top: 15, bottom: 30),
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          GestureDetector(
              onTap: ()=> pageViewController.goToPage(0),
              child: Obx(() => FaIcon(FontAwesomeIcons.home, color: pageViewController.currentPage.value == 0 ? AppColors.primaryColor : Colors.grey))
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff4d4d4d),
            ),
            child: FaIcon(FontAwesomeIcons.plus),
          ),
          Spacer(),
          GestureDetector(
            onTap: ()=> pageViewController.goToPage(3,title: "Profile"),
            child: Obx(() => FaIcon(FontAwesomeIcons.solidUser, color: pageViewController.currentPage.value == 3 ? AppColors.primaryColor : Colors.grey)),
          ),
        ],
      ),
    );
  }
}

// // Extension for safe image provider
// extension SafeImageProvider on String? {
//   ImageProvider get safeProvider {
//     var noProfileImage = "assets/images/no_profile.jpg";
//     if (this == null || this!.isEmpty) {
//       return AssetImage(noProfileImage);
//     }
    
//     try {
//       final uri = Uri.tryParse(this!);
//       if (uri == null || !uri.hasScheme) {
//         return AssetImage(noProfileImage);
//       }
      
//       return CachedNetworkImageProvider(this!);
//     } catch (e) {
//       return AssetImage(noProfileImage);
//     }
//   }
// }