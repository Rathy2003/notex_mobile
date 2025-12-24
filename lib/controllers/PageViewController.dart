import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final RxInt previousPage = 0.obs;
  final RxString pageTitle = "".obs;

  void goToPage(int newPage,{String title=""}) {
    if(title.isNotEmpty){
      pageTitle.value = title;
    }
    // Store current page as previous BEFORE changing
    previousPage.value = currentPage.value;
    // Update current page
    currentPage.value = newPage;

    // Animate page view
    pageController.animateToPage(
      newPage,
      duration: 300.milliseconds,
      curve: Curves.easeInOut,
    );
  }

  // Go back to previous page
  void goBack() {
    if (previousPage.value >= 0) {
      pageTitle.value = "";
      goToPage(previousPage.value);
    }
  }
}
