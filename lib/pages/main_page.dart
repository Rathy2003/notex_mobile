import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/PageViewController.dart';
import 'package:notex_mobile/pages/home_page.dart';
import 'package:notex_mobile/pages/profile_page.dart';
import 'package:notex_mobile/pages/search_note_page.dart';
import 'package:notex_mobile/pages/view_note_page.dart';
import 'package:notex_mobile/widgets/AppBar.dart';
import 'package:notex_mobile/widgets/BottomNavBar.dart';
import 'package:notex_mobile/widgets/CustomDrawer.dart';
import 'package:notex_mobile/widgets/ViewPageAppBar.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final PageViewController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx((){
          if(controller.currentPage.value == 0){
            return AppBarWidget(context);
          }else if(controller.currentPage.value != 1){
            return ViewPageAppBar();
          }else{
            return SizedBox();
          }
        }),
      ),
      drawer: CustomDrawer(),
      body: PageView(
        controller: controller.pageController,
        pageSnapping: false,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          SearchNotePage(),
          ViewNotePage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}