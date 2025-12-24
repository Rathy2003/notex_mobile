import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/PageViewController.dart';
import 'package:notex_mobile/utils/color.dart';

AppBar ViewPageAppBar() {
  final PageViewController pageViewController = Get.find();
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: IconButton(
      onPressed: () => pageViewController.goBack(),
      icon: FaIcon(FontAwesomeIcons.chevronLeft, color: AppColors.textColor),
    ),
    title: Obx(() {
      String pageTitle = pageViewController.pageTitle.value;
      return Text(
        pageTitle.isNotEmpty ? pageTitle : "",
        style: TextStyle(color: AppColors.textColor),
      );
    }),
  );
}
