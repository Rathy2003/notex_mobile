import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/controllers/PageViewController.dart';
import 'package:notex_mobile/utils/color.dart';

class NoteCard extends StatelessWidget {
  NoteCard({super.key,required this.index});
  final int index;
  final PageViewController pageViewController = Get.find();

  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    NoteController _controller = Get.find();

    return GestureDetector(
      onTap: (){
        _controller.onClickViewNote(_controller.notes_list[index]);
        pageViewController.goToPage(2,title: _controller.notes_list[index].title);
      },
      child: Dismissible(
          key: _key,
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 50),
            child: FaIcon(
              color: Colors.white,
              FontAwesomeIcons.pen
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            padding: EdgeInsets.only(right: 50),
            alignment: Alignment.centerRight,
            child: FaIcon(
                color: Colors.white,
                FontAwesomeIcons.trash
            ),
          ),
          child:  Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_controller.notes_list[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.fade,
                        ),
                      ),
                      Row(
                        children: [
                          Text(_controller.notes_list[index].created_at.toString(),
                            style: TextStyle(
                              color: AppColors.textColorSecondary
                            ),
                          ),
                          Text(" - ",
                            style: TextStyle(
                                color: AppColors.textColorSecondary
                            ),
                          ),
                          Text(_controller.notes_list[index].tags,
                            style: TextStyle(
                                color: AppColors.textColorSecondary
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                    child: Icon(
                        Icons.arrow_forward_ios_outlined,
                    )
                )
              ],
            ),
          ),
      ),
    );
  }
}
