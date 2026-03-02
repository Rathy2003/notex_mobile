import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Themecontroller extends GetxController {
  final box = GetStorage();
  var isDark = false.obs;

  @override
  void onInit() {
    isDark.value = box.read('darkMode') ?? false;
    super.onInit();
  }

  ThemeMode get themeMode =>
      isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDark.toggle();
    box.write('darkMode', isDark.value);
    Get.changeThemeMode(themeMode);
  }
}