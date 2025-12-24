import 'package:get/get.dart';
import 'package:notex_mobile/middleware/AuthMiddleware.dart';
import 'package:notex_mobile/pages/home_page.dart';
import 'package:notex_mobile/pages/login_page.dart';
import 'package:notex_mobile/pages/main_page.dart';
import 'package:notex_mobile/pages/profile_page.dart';
import 'package:notex_mobile/pages/profiles/profile_details_page.dart';
import 'package:notex_mobile/pages/search_note_page.dart';
import 'package:notex_mobile/pages/text_editor_page.dart';
import 'package:notex_mobile/pages/view_note_page.dart';

class AppRoutes{
  static const home = "/home";
  static const index = "/";
  static const editor = "/editor";
  static const search = "/search";
  static const view_note = "/view_note";
  static const login = "/login";
  static const profile = "/profile";
  static const profile_details = "/profile_details";

  static final routes = [
    GetPage(
      name: login,
      page: () => LoginPage()
    ),
    GetPage(name: editor,page: ()=> TextEditorPage()),
    GetPage(
        name: index,
        page: ()=> MainPage(),
        middlewares: [AuthMiddleware()]
    ),
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
    // Profile
    GetPage(
        name: profile,
        page: () => ProfilePage(),
        middlewares: [AuthMiddleware()]
    ),
    // Profile Details Page
    GetPage(
        name: profile_details,
        page: () => ProfileDetailsPage(),
        middlewares: [AuthMiddleware()]
    ),
  ];
}