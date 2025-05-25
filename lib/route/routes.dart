import 'package:get/get.dart';
import 'package:notex_mobile/middleware/AuthMiddleware.dart';
import 'package:notex_mobile/pages/home_page.dart';
import 'package:notex_mobile/pages/login_page.dart';
import 'package:notex_mobile/pages/profile_page.dart';
import 'package:notex_mobile/pages/search_note_page.dart';
import 'package:notex_mobile/pages/text_editor_page.dart';
import 'package:notex_mobile/pages/view_note_page.dart';

class AppRoutes{
  static const home = "/";
  static const editor = "/editor";
  static const search = "/search";
  static const view_note = "/view_note";
  static const login = "/login";
  static const profile = "/profile";

  static final routes = [
    GetPage(name: login,page: ()=> LoginPage()),
    GetPage(name: editor,page: ()=> TextEditorPage()),
    GetPage(
        name: home,
        page: ()=> HomePage(),
        middlewares: [AuthMiddleware()]
    ),
    GetPage(
        name: search,
        page: ()=> SearchNotePage(),
        middlewares: [AuthMiddleware()]
    ),
    GetPage(
        name: view_note,
        page: () => ViewNotePage(),
        middlewares: [AuthMiddleware()]
    ),
    GetPage(
        name: profile,
        page: () => ProfilePage(),
        middlewares: [AuthMiddleware()]
    )
  ];
}