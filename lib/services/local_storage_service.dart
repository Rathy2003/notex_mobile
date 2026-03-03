import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/models/NoteModel.dart';
import 'package:notex_mobile/models/UserModel.dart';

class LocalStorageService {
  final _box = GetStorage();

  List<NoteModel> loadNotesFromLocal() {
    var savedNotes = _box.read<List>('notes');
    if (savedNotes != null) {
      // tempNotesList.value =
      //     savedNotes.map((e) => NoteModel.fromJson(e)).toList();
      // notesList.value = getNotesByTags();
      return savedNotes.map((e) => NoteModel.fromJson(e)).toList();
    }
    return <NoteModel>[];
  }

  saveNotes(List<NoteModel> notesList) {
    if (notesList.isNotEmpty) {
      _box.write("notes", notesList.map((e) => e.toJson()).toList());
    }
  }

  getSelectedTags() {
    if (_box.read('selectedTags') != null) {
      List<dynamic> loadedTags = jsonDecode(_box.read('selectedTags')).toList();
      return loadedTags.cast<String>().toList();
    }
    return null;
  }

  clearFromStorage(String key) {
    _box.remove(key);
  }

  /// User
  saveUserInfo(User? user, String token) async {
    if (user != null) {
      await _box.write("user_info", json.encode(user.toJson()));
      await _box.write("_token", token);
    }
  }

  String? readToken() {
    final token = _box.read("_token");
    return token;
  }
}
