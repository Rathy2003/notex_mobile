import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/controllers/TagsController.dart';
import 'package:notex_mobile/widgets/CustomButton.dart';

class CustomFloatActionButton extends StatelessWidget {
  const CustomFloatActionButton({
    super.key,
    required this.isDark,
    required this.tagsController,
    required this.noteController,
  });

  final bool isDark;
  final TagsController tagsController;
  final NoteController noteController;

  @override
  Widget build(BuildContext context) {
    void clearSelectedTags() {
      tagsController.clearSelectedTags();

      /// Refresh Notes
      noteController.refreshNotesList();
    }

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      elevation: 0,
      backgroundColor: isDark ? Colors.white : Colors.black,
      foregroundColor: isDark ? Colors.black : Colors.white,
      activeBackgroundColor: isDark ? Colors.white : Colors.black,
      activeForegroundColor: isDark ? Colors.black : Colors.white,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      spacing: 12,
      curve: Curves.easeInOut,
      childrenButtonSize: const Size(55, 55), // size of child FABs
      children: [
        SpeedDialChild(
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          foregroundColor: isDark ? Colors.white : Colors.black,
          label: "add_note".tr,
          labelStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          labelBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
          child: const Icon(Icons.note_add),
          onTap: () => print("Add Note"),
        ),
        SpeedDialChild(
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          foregroundColor: isDark ? Colors.white : Colors.black,
          label: "add_tag".tr,
          labelStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          labelBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
          child: const Icon(Icons.tag),
          onTap: () => print("Add Tag"),
        ),

        /// Clear Selected Tags
        SpeedDialChild(
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          foregroundColor: isDark ? Colors.white : Colors.black,
          label: "clear_tags".tr,
          labelStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          labelBackgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
          child: const Icon(Icons.clear),
          onTap: () {
            if (tagsController.selectedTagsList.isNotEmpty) {
              _showDeleteDialog(clearSelectedTags, context);
            }
          },
        ),
      ],
    );
  }
}

void _showDeleteDialog(VoidCallback clearSelectedTag, BuildContext context) {
  Get.dialog(
    barrierDismissible: false,
    Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: IntrinsicHeight(
        // 👈 makes height dynamic based on content
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "confirm_delete_label".tr,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.merge(TextStyle(fontSize: 25)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'are_your_sure_to_delete_these_item'.tr,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.merge(TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    label: "no".tr,
                    bgColor: Colors.grey.shade300,
                    verticalPadding: 12,
                    borderRadius: 15,
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    label: "confirm_delete".tr,
                    verticalPadding: 12,
                    bgColor: Colors.red,
                    borderRadius: 15,
                    onPressed: () {
                      clearSelectedTag();
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
