import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notex_mobile/utils/environment.dart';

class NoteController extends GetxController{

  var notes_list = [].obs;
  var search_list = [].obs;
  var temp_notes_list = [];
  var isLoading = false.obs;
  // view note
  var selected_note = Map<String, dynamic>().obs;
  final box = GetStorage();

  @override
  onInit(){
    super.onInit();
    getNotes();
  }

  getSelectedTags(){
    if(box.read('selectedTags') != null){
      List<dynamic> loadedTags = jsonDecode(box.read('selectedTags')).toList();
      return loadedTags.cast<String>().toList();
    }
    return null;
  }

  getNotes() async{
      isLoading.value = true;
      var rp = await http.get(Uri.parse("${Environment.API_BASE_URL}/notes?userid=N9Wgm26kMk5yKTNfWyA0"));
      var result = await rp.body;
      temp_notes_list = json.decode(result);
      notes_list.value = getFilterNotesByTags();
      isLoading.value = false;
  }

  saveChangeContent(String content){
    var body = json.encode({
      "noteid": selected_note['id'],
      "content": content,
    });
    http.put(Uri.parse("${Environment.API_BASE_URL}/note/edit"),
      headers: {
        'Content-Type': 'application/json',
      },
      body:body
    ).then((response){
      var result = json.decode(response.body);
      if(result['status'] == 200){
        selected_note['content'] = content;
        Get.back();
      }
    });
  }

  onUpdateFilterNotes(){
    notes_list.value = getFilterNotesByTags();
  }

  onClearSearchResult(){
    search_list.clear();
  }

  onClickViewNote(Map<String, dynamic> item){
    selected_note.value = Map<String,dynamic>.from(item).obs;
  }

  getFilterNotesByTags(){
    var filterNotes = [];
    var selectedTagsList = getSelectedTags();
    if(selectedTagsList == null){
      return temp_notes_list;
    }
    for (var item in temp_notes_list) {
      if(selectedTagsList.contains(item['tags'])){
        filterNotes.add(item);
      }
    }
    return filterNotes;
  }

  onSearchNotes(String query){
    var result = [];
    temp_notes_list.forEach((item) {
        if(item['title'].toLowerCase().indexOf(query.toLowerCase()) > -1){
          result.add(item);
        }
    });
    search_list.value = result;
  }
}