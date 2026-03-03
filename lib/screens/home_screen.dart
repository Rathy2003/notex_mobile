import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/widgets/AppBar.dart';
import 'package:notex_mobile/widgets/CustomDrawer.dart';
import 'package:notex_mobile/widgets/TagsCard.dart';
import 'package:notex_mobile/widgets/NoteCard.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final NoteController noteController = Get.find();
  final TagsController tagsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarWidget(context),
      drawer: CustomDrawer(),
      body: Obx(() {
        if (noteController.isLoading.value) {
          return Center(
            child: SpinKitFadingCircle(
              color: isDark ? Colors.white : Theme.of(context).primaryColor,
              size: 60,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Container(
                margin: const EdgeInsets.only(top: 25),
                height: 50,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: tagsController.tagsList.length,
                  itemBuilder: (context, index) => TagsCard(index: index),
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 25),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ✅ Notes list scrolls only
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView.separated(
                  itemCount: noteController.notesList.length,
                  itemBuilder: (context, index) => NoteCard(index: index),
                  separatorBuilder:
                      (context, index) => Divider(
                        height: 1,
                        color: const Color.fromARGB(
                          153,
                          158,
                          158,
                          158,
                        ).withOpacity(0.2),
                      ),
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        elevation: 0,
        backgroundColor: isDark ? Colors.deepPurple : Colors.blue,
        foregroundColor: Colors.white,
        activeBackgroundColor:
            isDark ? Colors.deepPurpleAccent : Colors.blueAccent,
        activeForegroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        spacing: 12,
        curve: Curves.easeInOut,
        childrenButtonSize: const Size(55, 55), // size of child FABs
        children: [
          SpeedDialChild(
            backgroundColor:
                isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            foregroundColor: isDark ? Colors.white : Colors.black,
            label: "Add Note",
            labelStyle: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
            labelBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
            child: const Icon(Icons.note_add),
            onTap: () => print("Add Note"),
          ),
          SpeedDialChild(
            backgroundColor:
                isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            foregroundColor: isDark ? Colors.white : Colors.black,
            label: "Add Tag",
            labelStyle: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
            labelBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
            child: const Icon(Icons.tag),
            onTap: () => print("Add Tag"),
          ),
        ],
      ),
    );
  }
}
