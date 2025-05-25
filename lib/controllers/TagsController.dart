import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import '../utils/environment.dart';

class TagsController extends GetxController{
  var tagsList = [].obs;
  var selectedTagsList = <String>[].obs;
  final box = GetStorage();
  final NoteController noteController = Get.find();

  @override
  onInit(){
    super.onInit();
    getSelectedTags();
    getTags();
  }

  void getSelectedTags(){
    if(box.read('selectedTags') != null){
      List<dynamic> loadedTags = jsonDecode(box.read('selectedTags')).toList();
      selectedTagsList.value = loadedTags.cast<String>().toList();
    }
  }

  void onSelectedTagsToggle(String tags){
    if(!selectedTagsList.contains(tags)){
      selectedTagsList.add(tags);
    }else{
      selectedTagsList.remove(tags);
    }

    if(selectedTagsList.isEmpty){
      box.remove('selectedTags');
    }else{
      box.write('selectedTags', json.encode(selectedTagsList));
    }
    noteController.onUpdateFilterNotes();
  }

  getTags() async{
    var rp = await http.get(Uri.parse("${Environment.API_BASE_URL}/tags?userid=N9Wgm26kMk5yKTNfWyA0"));
    var result = await rp.body;
    tagsList.value = json.decode(result)['data'];
  }
}