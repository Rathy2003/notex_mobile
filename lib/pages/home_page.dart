import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/widgets/AppBar.dart';
import 'package:notex_mobile/widgets/BottomNavBar.dart';
import 'package:notex_mobile/widgets/TagsCard.dart';
import 'package:notex_mobile/widgets/NoteCard.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class HomePage extends StatelessWidget {
  // const HomePage({super.key});
  final NoteController noteController = Get.find();
  final TagsController tagsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBarWidget(),
      body: Obx(() => noteController.isLoading.value ?
          Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 60,
            ),
          )
          :
          ListView(
            children: [
              Obx(
                    () => Container(
                  margin: EdgeInsets.only(top: 25),
                  height: 40,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: tagsController.tagsList.length,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    itemBuilder: (context, index) {
                      return TagsCard(index: index);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 25);
                    },
                  ),
                ),
              ),

              Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: noteController.notes_list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [NoteCard(index: index), Divider()],
                  );
                },
              ),
            ),
            ],
          )
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
