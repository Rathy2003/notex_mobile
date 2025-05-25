import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/route/routes.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  Get.put(NoteController());
  Get.put(TagsController());
  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        // GlobalMaterialLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
    )
  );
}