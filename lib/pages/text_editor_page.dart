import 'package:dart_quill_delta/src/delta/delta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/utils/color.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/widgets/CustomButton.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class TextEditorPage extends StatefulWidget {
  @override
  _TextEditorPageState createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final NoteController _noteController = Get.find();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var delta = HtmlToDelta().convert(_noteController.selected_note['content'], transformTableAsEmbed: false);
    _controller.document = quill.Document.fromDelta(delta);
  }

  Widget build(BuildContext context) {

    double halfHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
              _noteController.selected_note['title'],
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
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
          backgroundColor: AppColors.primaryColor
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
           quill.QuillSimpleToolbar(
             controller: _controller,
             config: const quill.QuillSimpleToolbarConfig(
               showSearchButton: false,
               showListCheck: false,
               showFontFamily: false,
             ),

           ),
            quill.QuillEditor.basic(
              controller: _controller,
              config: const quill.QuillEditorConfig(
                  customStyles: quill.DefaultStyles(
                  )
              ),
            ),
            SizedBox(height: 45,),
            Container(
              padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom:50),
              child: CustomButton(
                  onPressed: (){
                    final delOpt = _controller.document.toDelta().toJson();
                    final converter = QuillDeltaToHtmlConverter(
                      delOpt,
                      ConverterOptions.forEmail(),
                    );
                    final html = converter.convert();
                    _noteController.saveChangeContent(html);
                  },
                  label: "Save"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
