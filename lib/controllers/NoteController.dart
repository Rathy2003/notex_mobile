import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notex_mobile/models/NoteModel.dart';
import 'package:notex_mobile/utils/environment.dart';

class NoteController extends GetxController{

  var search_list = [].obs;
  RxList<NoteModel> temp_notes_list = <NoteModel>[].obs;
  RxList<NoteModel> notes_list = <NoteModel>[].obs;
  var isLoading = false.obs;

  // view note
  var selected_note = Map<String, dynamic>().obs;
  final box = GetStorage();

  @override
  onInit() async{
    super.onInit();
    var connectivity = await Connectivity().checkConnectivity();
    if(connectivity.contains(ConnectivityResult.none)){
      loadNotesFromLocal();
    }else{
        getNotes();
    }
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
      List<dynamic> result = json.decode(rp.body);
      temp_notes_list.value = result.map((e)=>NoteModel.fromJson(e)).toList();
      notes_list.value = getFilterNotesByTags();
      saveNoteToLocal();
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
        getNotes();
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

  onClickViewNote(NoteModel item){
    selected_note.value = Map<String,dynamic>.from(item.toJson()).obs;
  }

  getFilterNotesByTags(){
    List<NoteModel> filterNotes = <NoteModel>[];
    var selectedTagsList = getSelectedTags();
    if(selectedTagsList == null){
      return temp_notes_list;
    }
    for (var item in temp_notes_list) {
      if(selectedTagsList.contains(item.tags)){
        filterNotes.add(item);
      }
    }
    return filterNotes.toList();
  }

  onSearchNotes(String query){
    var result = [];
    temp_notes_list.forEach((item) {
        if(item.title.toLowerCase().contains(query.toLowerCase())){
          result.add(item);
        }
    });
    search_list.value = result;
  }

  saveNoteToLocal(){
    if(notes_list.isNotEmpty){
      box.write("notes", temp_notes_list.map((e)=> e.toJson()).toList());
    }
  }

  loadNotesFromLocal(){
    var savedNotes = box.read<List>('notes');
    if(savedNotes != null){
      temp_notes_list.value = savedNotes.map((e)=>NoteModel.fromJson(e)).toList();
      notes_list.value = getFilterNotesByTags();
    }
  }
}