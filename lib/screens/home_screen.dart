import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Scaffold(
      appBar: AppBarWidget(context),
      drawer: CustomDrawer(),
      body: Obx(
        () =>
            noteController.isLoading.value
                ? Center(
                  child: SpinKitFadingCircle(
                    color: Theme.of(context).primaryColor,
                    size: 60,
                  ),
                )
                : ListView(
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
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: noteController.notes_list.length,
                        itemBuilder: (context, index) {
                          return NoteCard(index: index);
                        },
                        separatorBuilder: (context, index) {
                          return Divider(color: Colors.grey.withOpacity(0.5));
                        },
                      ),
                    ),
                  ],
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define the action here (e.g., add a new item)
          print('FAB pressed!');
        },
        elevation: 0,
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: FaIcon(FontAwesomeIcons.plus), // The icon inside the button
        tooltip:
            'Add New Item', // Optional: provides a description for accessibility
      ),
    );
  }
}
