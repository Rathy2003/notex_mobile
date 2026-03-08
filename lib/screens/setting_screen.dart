import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/AppController.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/controllers/ThemeController.dart';
import 'package:notex_mobile/models/language.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/widgets/LanguageSelectorBottomSheet.dart';

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

/// Language Data
final List<Language> languages = [
  Language(code: 'en', name: 'English', flag: '🇺🇸'),
  Language(code: 'km', name: 'ខ្មែរ', flag: '🇰🇭'),
];

final AuthController authController = Get.find();
final Appcontroller appcontroller = Get.find();
final themeController = Get.find<Themecontroller>();

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    final isDark = themeController.isDark.value;
    return Center(
      child: Scaffold(
        appBar: AppBar(title: Text("setting".tr), centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.1),
              ),
              child: Column(
                children: [
                  /// Theme Switch
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.solidMoon),
                        SizedBox(width: 10),
                        Text("theme".tr, style: TextStyle(fontSize: 18)),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.globe),
                        SizedBox(width: 10),
                        Text("language".tr, style: TextStyle(fontSize: 18)),
                        Spacer(),
                        InkWell(
                          onTap:
                              () => showLanguageSelector(
                                context,
                                appcontroller.locale.value.languageCode,
                                appcontroller,
                              ),
                          child: Text(
                            languages
                                .firstWhere(
                                  (ele) =>
                                      ele.code ==
                                      appcontroller.locale.value.languageCode,
                                )
                                .name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showLanguageSelector(
  BuildContext context,
  String selectedCode,
  Appcontroller appController,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => LanguageSelectorSheet(
          languages: languages,
          selectedCode: selectedCode,
          onSelected: (language) {
            // Handle language change
            appcontroller.changeLocale(Locale(language.code));
            Navigator.pop(context);
          },
        ),
  );
}
