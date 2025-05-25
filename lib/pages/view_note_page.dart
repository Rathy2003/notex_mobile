import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/utils/color.dart';

class ViewNotePage extends StatelessWidget {
  const ViewNotePage({super.key});

  @override
  Widget build(BuildContext context) {

    NoteController noteController = Get.find();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
            noteController.selected_note['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
        ),
        leading: Center(
          child: IconButton(
              onPressed: ()=>Get.back(),
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.white,
              )
          ),
        ),
        actions: [
          IconButton(
              onPressed: ()=> Get.toNamed(AppRoutes.editor),
              icon: FaIcon(
                FontAwesomeIcons.pen,
                size: 20,
                color: AppColors.textColor,
              )
          ),
          SizedBox(width: 10,),
          FaIcon(
            FontAwesomeIcons.shareNodes,
            color: AppColors.textColor,
          ),
          SizedBox(width: 25,)

        ],
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 4.0,
          boundaryMargin: EdgeInsets.all(20),
          child: Obx(()=> SingleChildScrollView(
            child: SelectionArea(
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
          )),
        ),
      ),
    );
  }
}
