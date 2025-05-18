import 'package:get/get.dart';
import 'package:notex_mobile/pages/home_page.dart';
import 'package:notex_mobile/pages/search_note_page.dart';
import 'package:notex_mobile/pages/view_note_page.dart';

class AppRoutes{
  static const home = "/";
  static const search = "/search";
  static const view_note = "/view_note";
  static final routes = [
    GetPage(name: home, page: ()=> HomePage()),
    GetPage(name: search, page: ()=> SearchNotePage()),
    GetPage(name: view_note, page: () => ViewNotePage())
  ];
}