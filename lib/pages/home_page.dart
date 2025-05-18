import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/widgets/AppBar.dart';
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 45, right: 45, top: 15, bottom: 30),
        color: AppColors.secondaryColor,
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.home, color: Colors.white),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xff4d4d4d),
              ),
              child: FaIcon(FontAwesomeIcons.plus, color: Colors.white),
            ),
            Spacer(),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 45,
              width: 45,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                  "https://play-lh.googleusercontent.com/jInS55DYPnTZq8GpylyLmK2L2cDmUoahVacfN_Js_TsOkBEoizKmAl5-p8iFeLiNjtE=w526-h296-rw",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
