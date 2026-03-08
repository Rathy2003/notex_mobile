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
import 'package:notex_mobile/services/api_service.dart';
import 'package:notex_mobile/services/local_storage_service.dart';
import 'package:notex_mobile/theme/app_theme.dart';
import 'package:notex_mobile/translations/app_translations.dart';
import 'package:notex_mobile/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Get.put(ApiService());
  Get.put(LocalStorageService());
  Get.put(Appcontroller());
  Get.put(Themecontroller());
  Get.put(PageViewController());
  Get.put(AuthController());
  Get.put(NoteController());
  Get.put(TagsController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        themeMode: themeController.themeMode,
        darkTheme: darkModeTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.auth,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
