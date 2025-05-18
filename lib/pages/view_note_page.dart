import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/utils/color.dart';

class ViewNotePage extends StatelessWidget {
  const ViewNotePage({super.key});

  @override
  Widget build(BuildContext context) {

    NoteController noteController = Get.find();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Center(
          child: InkWell(
            onTap: ()=> Get.back(),
            child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          FaIcon(
            FontAwesomeIcons.shareNodes,
            color: AppColors.textColor,
          ),
          SizedBox(width: 25,)
        ],
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: HtmlWidget(
              '''
                <body class="container">
                 ${noteController.selected_note['content']}
                </body>
              ''',
              customStylesBuilder: (element) {
                if(element.localName == 'code'){
                  return {
                    'font-size': '1em',
                    'color': '#d63384',
                    'word-wrap': 'break-word'
                  };
                }

                if (element.classes.contains('container')) {
                  return {
                      'background-color': 'black'
                  };
                }
                return null;
              },
            textStyle: TextStyle(
              color: AppColors.textColor
            ),
          ),
        ),
      ),
    );
  }
}
