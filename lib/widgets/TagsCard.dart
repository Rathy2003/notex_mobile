import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/TagsController.dart';

class TagsCard extends StatelessWidget {
  const TagsCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              /// border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(radius),
              color: _getBackgroundColor(isSelected, isDark),
            ),
            child: Text(
              tagName.toUpperCase(),
              style: TextStyle(
                fontSize: textFontSize,
                color: _getForegroundColor(isSelected, isDark),
              ),
            ),
          ),
        ),
      );
    });
  }

  Color _getBackgroundColor(bool isSelected, bool isDark) {
    Color backgroundColor = isDark ? Colors.white : Colors.black;
    return backgroundColor.withValues(alpha: isSelected ? 1 : 0.5);
  }

  Color _getForegroundColor(bool isSelected, bool isDark) {
    Color foregroundColor =
        isDark ? (isSelected ? Colors.black : Colors.white) : Colors.white;
    return foregroundColor;
  }
}
