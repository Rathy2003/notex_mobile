import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notex_mobile/models/NoteModel.dart';
import 'package:notex_mobile/services/api_service.dart';
import 'package:notex_mobile/services/local_storage_service.dart';
import 'package:notex_mobile/utils/environment.dart';

class NoteController extends GetxController {
  var searchNotesList = [].obs;
  RxList<NoteModel> tempNotesList = <NoteModel>[].obs;
  RxList<NoteModel> notesList = <NoteModel>[].obs;
  var isLoading = false.obs;
  final Dio dio = Dio();
  final ApiService _apiService = Get.find();
  final LocalStorageService _localStorageService = Get.find();

  // view note
  var selectedNotes = <String, dynamic>{}.obs;
  final box = GetStorage();

  @override
  onInit() async {
    super.onInit();
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) {
      tempNotesList.value = _localStorageService.loadNotesFromLocal();
      notesList.value = _localStorageService.getSelectedTags();
    } else {
      getAllNotes();
    }
  }

  void getAllNotes() async {
    isLoading.value = true;
    tempNotesList.value = await _apiService.fetchAllNotes();
    isLoading.value = false;
    notesList.value = getNotesByTags();

    /// save notes from db to local
    _localStorageService.saveNotes(tempNotesList);
  }

  saveChangeContent(String content) {
    var body = json.encode({"noteid": selectedNotes['id'], "content": content});
    http
        .put(
          Uri.parse("${Environment.API_BASE_URL}/note/edit"),
          headers: {'Content-Type': 'application/json'},
          body: body,
        )
        .then((response) {
          var result = json.decode(response.body);
          if (result['status'] == 200) {
            selectedNotes['content'] = content;

            /// getNotes();
            Get.back();
          }
        });
  }

  getNotesByTags() {
    List<NoteModel> filterNotes = <NoteModel>[];
    var selectedTagsList = _localStorageService.getSelectedTags();
    if (selectedTagsList == null) {
      return tempNotesList;
    }
    for (var item in tempNotesList) {
      if (selectedTagsList.contains(item.tags)) {
        filterNotes.add(item);
      }
    }
    return filterNotes.toList();
  }
  
  /// Event Handler
  onSearchNotes(String query) {
    var result = [];
    for (var item in tempNotesList) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        result.add(item);
      }
    }
    searchNotesList.value = result;
  }

  onClearSearchResult() {
    searchNotesList.clear();
  }

  onClickViewNote(NoteModel item) {
    selectedNotes.value = Map<String, dynamic>.from(item.toJson()).obs;
  }

   onUpdateFilterNotes() {
    notesList.value = getNotesByTags();
  }
}
