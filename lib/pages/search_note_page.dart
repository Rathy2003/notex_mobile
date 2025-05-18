import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/utils/color.dart';
import 'package:get/get.dart';

class SearchNotePage extends StatelessWidget {
  // const SearchNotePage({super.key});

  NoteController noteController = Get.find();
  SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            SizedBox(height: 15,),
            // back button and search bar
            Flexible(
              flex: 4,
                child:  Row(
                  children: [
                    // back button
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: ()=> {
                          noteController.onClearSearchResult(),
                          Get.back()
                        },
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // search bar
                    SizedBox(width: 20,),
                    Flexible(
                        flex: 14,
                        child: SearchBar(
                          onChanged: (value) {
                            noteController.onSearchNotes(value);
                          },
                          controller: searchController,
                          constraints: BoxConstraints(
                              minHeight: 45
                          ),
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              )
                          ),
                          textStyle: WidgetStatePropertyAll(
                              TextStyle(
                                  color: Colors.white
                              )
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              return Color(0xff4d4d4d);
                            },
                          ),
                          hintText: "Find your note here...",
                          hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                                (Set<MaterialState> states) {
                              return TextStyle(color: AppColors.textColorSecondary);
                            },
                          ),
                        )
                    ),
                  ],
                ),
            ),
            SizedBox(height: 5,),
            
            // search suggestion
           Obx(() =>  Flexible(
               flex: 25,
               child: ListView.builder(
                 shrinkWrap: true,
                 itemCount: noteController.search_list.length,
                 itemBuilder: (context, index) {
                   return ListTile(
                      onTap: (){
                        noteController.onClickViewNote(noteController.search_list[index]);
                        Get.toNamed('/view_note');
                      },
                      title: Text(noteController.search_list[index]['title'],style: TextStyle(color: AppColors.textColor),),
                      trailing: FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: AppColors.textColor,
                      ),
                   );
                 },
               )
           ))
          ],
        ),
      ),
    );
  }
}
