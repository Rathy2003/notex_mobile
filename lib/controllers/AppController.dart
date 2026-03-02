import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Appcontroller extends GetxController {
  var locale = Locale("en", "US").obs;

  @override
  void onInit() {
    super.onInit();
    initLocale();
  }

  void initLocale() {
    locale.value = Locale(GetStorage().read("locale") ?? "en", "US");
    Get.updateLocale(locale.value);
  }

  void changeLocale(Locale locale) {
    this.locale.value = locale;
    Get.updateLocale(locale);

    /// save to storage
    GetStorage().write("locale", locale.languageCode);
  }
}
