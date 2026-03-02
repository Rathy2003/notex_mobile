import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/controllers/AppController.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/controllers/PageViewController.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/controllers/ThemeController.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/translations/app_translations.dart';
import 'package:notex_mobile/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Get.put(Appcontroller());
  Get.put(Themecontroller());
  Get.put(PageViewController());
  Get.put(AuthController());
  Get.put(NoteController());
  Get.put(TagsController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.find<Themecontroller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        translations: AppTranslations(),
        locale: Get.find<Appcontroller>().locale.value,
        fallbackLocale: const Locale('en', 'US'),
        localizationsDelegates: const [FlutterQuillLocalizations.delegate],
        theme: lightModeTheme,
        darkTheme: darkModeTheme,
        themeMode: themeController.themeMode, // 👈 dynamic now
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
