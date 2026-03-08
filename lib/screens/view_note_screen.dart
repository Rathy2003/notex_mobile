import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/widgets/OptionItemCard.dart';

class ViewNoteScreen extends StatelessWidget {
  const ViewNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController noteController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text(
          noteController.selectedNotes['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const FaIcon(size: 20, FontAwesomeIcons.chevronLeft),
        ),
        actions: [
          IconButton(
            // onPressed: () => Get.toNamed(AppRoutes.editor),
            onPressed: () => showMoreOption(context),
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical, size: 18),
          ),
          // const SizedBox(width: 10),
          // const FaIcon(FontAwesomeIcons.shareNodes),
          // const SizedBox(width: 25),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: SelectionArea(
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              boundaryMargin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16.0), // <-- padding applied here
                child: HtmlWidget(
                  noteController.selectedNotes['content'] ?? '',
                  textStyle: const TextStyle(fontSize: 16),
                  customStylesBuilder: (element) {
                    // Style code blocks
                    if (element.localName == 'code') {
                      return {
                        'font-size': '0.95em',
                        'font-family': 'monospace',
                        'color': '#f8f8f2',
                        'background-color': '#282a36',
                        'padding': '6px 10px',
                        'border-radius': '8px',
                        'margin': '4px 0',
                        'display': 'inline-block',
                        'box-shadow': '0 2px 4px rgba(0,0,0,0.2)',
                        'word-wrap': 'break-word',
                      };
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showMoreOption(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                OptionItemCard(
                  title: "edit".tr,
                  icon: FontAwesomeIcons.penToSquare,
                  onTap: () => Get.toNamed(AppRoutes.editor),
                ),
                SizedBox(width: 15),
                OptionItemCard(
                  title: "share".tr,
                  icon: FontAwesomeIcons.shareNodes,
                ),
              ],
            ),
          ),
        ),
  );
}
