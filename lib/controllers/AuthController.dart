import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notex_mobile/models/UserModel.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/utils/environment.dart';

class AuthController extends GetxController {
  // Observables
  var isLogin = false.obs;
  var email = "".obs;
  var password = "".obs;
  var isPasswordHidden = true.obs;
  var userInfo = Rxn<User>();
  var errors = <String, RxString>{"email": "".obs, "password": "".obs}.obs;

  var isReady = false.obs;

  // Storage
  final GetStorage _box = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      _loadFromLocal();
    } else {
      await _checkAuth();
    }
  }

  /// LOGIN PROCESS
  Future<void> processLogin(String emailInput, String passwordInput) async {
    clearErrorsMessage();

    if (!isValidEmail(emailInput)) {
      errors['email']?.value = "Please provide a valid email";
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("${Environment.API_BASE_URL}/user/login"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": emailInput, "password": passwordInput}),
      );

      final result = json.decode(response.body);

      if (result['status'] == 200) {
        final token = result['token'];
        _box.write("_token", token);
        userInfo.value = User.fromJson(result['data']);
        isLogin.value = true;
        await _saveToLocal();
        Get.offAllNamed(AppRoutes.index);
      } else {
        final message = result['message'] ?? "Login failed";
        errors['email']?.value = message;
        errors['password']?.value = message;
      }
    } catch (e) {
      errors['email']?.value = "Network error, please try again.";
    }
  }

  /// CHECK EXISTING AUTH
  Future<void> _checkAuth() async {
    final token = _box.read("_token");
    if (token == null) {
      isReady.value = true;
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("${Environment.API_BASE_URL}/user/auth"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"token": token}),
      );

      final result = json.decode(response.body);

      if (result['status'] == 200) {
        userInfo.value = User.fromJson(result['data']);
        isLogin.value = true;
        Get.offAllNamed(AppRoutes.index);
      } else {
        isReady.value = true; // token invalid or expired
      }
    } catch (e) {
      isReady.value = true;
    }
  }

  /// LOGOUT
  void processLogout() {
    _box.remove("_token");
    _box.remove("tags");
    _box.remove("notes");
    _box.remove("user_info");
    isLogin.value = false;
    isReady.value = true;
    userInfo.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  /// CLEAR ERRORS
  void clearErrorsMessage() {
    errors['email']?.value = "";
    errors['password']?.value = "";
  }

  /// EMAIL VALIDATION
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  /// LOCAL STORAGE
  Future<void> _saveToLocal() async {
    final user = userInfo.value;
    if (user != null) {
      await _box.write("user_info", json.encode(user.toJson()));
    }
  }

  void _loadFromLocal() {
    final data = _box.read("user_info");
    if (data != null) {
      final user = User.fromJson(json.decode(data));
      userInfo.value = user;
      isLogin.value = true;
      Get.offAllNamed(AppRoutes.index);
    } else {
      isReady.value = true;
    }
  }
}
