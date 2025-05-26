import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/controllers/NoteController.dart';
import 'package:notex_mobile/models/TagsModel.dart';
import '../utils/environment.dart';

class TagsController extends GetxController{
  RxList<TagsModel>  tagsList = <TagsModel>[].obs;
  var selectedTagsList = <String>[].obs;
  final box = GetStorage();
  final NoteController noteController = Get.find();

  @override
  onInit() async{
    super.onInit();

    var connectivity = await Connectivity().checkConnectivity();
    getSelectedTags();
    if(connectivity.contains(ConnectivityResult.none)){
      loadTagsFromLocal();
    }else{
      getTags();
    }
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
    List<dynamic> result = json.decode(rp.body)['data'];
    tagsList.value = result.map((item)=> TagsModel.fromJson(item)).toList();
    saveTagsToLocal();

  }

  saveTagsToLocal(){
    if(tagsList.isNotEmpty){
      box.write("tags", tagsList.map((e)=> e.toJson()).toList());
    }
  }

  loadTagsFromLocal(){
    var savedTags = box.read<List>('tags');
    if(savedTags != null){
      tagsList.value = savedTags.map((e)=> TagsModel.fromJson(e)).toList();
    }
  }
}