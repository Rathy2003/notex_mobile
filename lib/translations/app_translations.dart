import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'sign_in': 'Sign In',
      'password': 'Password',
      'email': 'Email Address',
      'home': 'Home',
      'profile': 'Profile',
      'search_note_caption': 'find your note here...',
      'setting': "Setting",
      'theme': "Theme",
      'language': "Language",
      'logout': "Logout",
    },
    'km_KH': {
      'sign_in': 'ចូលគណនី',
      'password': 'ពាក្យសម្ងាត់',
      'email': 'អាសយដ្ឋានអ៊ីមែល',
      'home': 'ទំព័រដើម',
      'profile': 'គណនី',
      'search_note_caption': 'ស្វែងរកការកត់ចំណាំ...',
      'setting': "ការកំណត់",
      'theme': "ផ្ទៃ",
      'language': "ភាសា",
      'logout': "ចាកចេញ",
    },
  };
}
