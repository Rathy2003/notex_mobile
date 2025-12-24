import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/controllers/PageViewController.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/utils/theme.dart';
void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PageViewController());
  Get.put(AuthController());
  Get.put(NoteController());
  Get.put(TagsController());
  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
      ],
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
    )
  );
}