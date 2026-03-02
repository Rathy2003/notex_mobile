import 'package:get/get.dart';
import 'package:notex_mobile/middleware/AuthMiddleware.dart';
import 'package:notex_mobile/screens/home_screen.dart';
import 'package:notex_mobile/screens/login_screen.dart';
import 'package:notex_mobile/screens/setting_screen.dart';
import 'package:notex_mobile/screens/profiles/profile_details_screen.dart';
import 'package:notex_mobile/screens/search_note_screen.dart';
import 'package:notex_mobile/screens/text_editor_page.dart';
import 'package:notex_mobile/screens/view_note_screen.dart';

class AppRoutes {
  static const home = "/home";
  static const index = "/";
  static const editor = "/editor";
  static const search = "/search";
  static const view_note = "/view_note";
  static const login = "/login";
  static const setting = "/setting";
  static const profile_details = "/profile_details";

  static final routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: editor, page: () => TextEditorPage()),
    GetPage(
      name: index,
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: search,
      page: () => SearchNoteScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: view_note,
      page: () => ViewNoteScreen(),
      middlewares: [AuthMiddleware()],
    ),
    // Profile
    GetPage(
      name: setting,
      page: () => SettingScreen(),
      middlewares: [AuthMiddleware()],
    ),
    // Profile Details Page
    GetPage(
      name: profile_details,
      page: () => ProfileDetailsScreen(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
