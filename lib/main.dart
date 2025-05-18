import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/route/routes.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NoteController());
  Get.put(TagsController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
    )
  );
}