import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/AppController.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/controllers/ThemeController.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:get/get.dart';

// ignore: prefer_typing_uninitialized_variables
var buildContext;

List<Map<String, dynamic>> menuItems = [
  {
    "title": "Edit Profile",
    "icon": FaIcon(FontAwesomeIcons.solidUser),
    "route": AppRoutes.profile_details,
  },
  {
    "title": "Settings",
    "icon": FaIcon(FontAwesomeIcons.gear),
    "routes": AppRoutes.search,
  },
  {"title": "Sign Out", "icon": FaIcon(FontAwesomeIcons.arrowRightFromBracket)},
];

final AuthController authController = Get.find();
final Appcontroller appcontroller = Get.find();
final themeController = Get.find<Themecontroller>();

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Center(
      child: Scaffold(
        appBar: AppBar(title: Text("setting".tr), centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                /// Theme Switch
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.solidMoon),
                      SizedBox(width: 10),
                      Text("theme".tr),
                      Spacer(),
                      Obx(
                        () => Switch(
                          value: themeController.isDark.value,
                          onChanged: (value) {
                            themeController.toggleTheme();
                          },
                          activeColor:
                              Colors.white, // thumb when ON (dark mode)
                          activeTrackColor: Colors.blueAccent.withOpacity(
                            0.7,
                          ), // track when ON
                          inactiveThumbColor:
                              Get.isDarkMode
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade800, // thumb when OFF
                          inactiveTrackColor:
                              Get.isDarkMode
                                  ? Colors.grey.shade600.withOpacity(0.3)
                                  : Colors.grey.shade400.withOpacity(
                                    0.5,
                                  ), // track when OFF
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.withOpacity(0.5)),

                /// Language Switch
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.globe),
                      SizedBox(width: 10),
                      Text("language".tr),
                      Spacer(),
                      Obx(
                        () => DropdownButton(
                          value: appcontroller.locale.value.languageCode,
                          items: [
                            DropdownMenuItem(
                              value: "en",
                              child: Text("English"),
                            ),
                            DropdownMenuItem(
                              value: "km",
                              child: Text("ភាសាខ្មែរ"),
                            ),
                          ],
                          onChanged: (value) {
                            appcontroller.changeLocale(Locale(value!));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//   Future<void> checkIsLogout(Map<String, dynamic> menuItem) async {
//     if (menuItem["title"] == "Sign Out") {
//       await _showLogoutDialog();
//     } else {
//       Get.toNamed(menuItem["route"]);
//     }
//   }
// }

// Future<void> _showLogoutDialog() async {
//   final screenWidth = MediaQuery.of(buildContext).size.width;
//   return showDialog<void>(
//     context: buildContext,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text(''),
//         insetPadding: EdgeInsets.symmetric(horizontal: 20),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         contentPadding: EdgeInsets.zero,
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         content: SizedBox(
//           width: screenWidth,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               FaIcon(FontAwesomeIcons.arrowRightFromBracket, size: 80),
//               SizedBox(height: 15),
//               Text("Are you sure to leave?", style: TextStyle(fontSize: 18)),

//               SizedBox(height: 20),

//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 15,
//                   right: 15,
//                   top: 15,
//                   bottom: 30,
//                 ),
//                 child: SizedBox(
//                   height: 50,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: CustomButton(
//                           bgColor: AppColors.secondaryColor,
//                           label: "Cancel",
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ),
//                       SizedBox(width: 15),
//                       Expanded(
//                         child: CustomButton(
//                           label: "Sign Out",
//                           bgColor: AppColors.primaryColor,
//                           fgColor: Colors.black,
//                           onPressed: () {
//                             authController.processLogout();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // actions: <Widget>[
//         //   TextButton(
//         //     child: const Text('Approve'),
//         //     onPressed: () {
//         //       Navigator.of(context).pop();
//         //     },
//         //   ),
//         // ],
//       );
//     },
//   );
// }
