import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/utils/color.dart';

class TagsCard extends StatelessWidget {
  const TagsCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    TagsController tagsController = Get.find();
    double radius = 10;
    double textFontSize = 17;

    return Obx(() {
      final String tagName = tagsController.tagsList[index].name;
      final bool isSelected = tagsController.selectedTagsList.contains(tagName);

      return Material(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            tagsController.onSelectedTagsToggle(tagName);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: isSelected ? Colors.white : AppColors.secondaryColor,
            ),
            child: Text(
              tagName.toUpperCase(),
              style: TextStyle(
                fontSize: textFontSize,
                color: isSelected ? Colors.black : AppColors.textColor,
              ),
            ),
          ),
        ),
      );
    });
  }
}
