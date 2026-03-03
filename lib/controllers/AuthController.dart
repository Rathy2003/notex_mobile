import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notex_mobile/models/AuthStatusEnum.dart';
import 'package:notex_mobile/models/UserModel.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/services/api_service.dart';
import 'package:notex_mobile/services/local_storage_service.dart';

class AuthController extends GetxController {
  var isLogin = false.obs;
  var email = "".obs;
  var password = "".obs;
  var isPasswordHidden = true.obs;
  var userInfo = Rxn<User>();
  var errors = <String, RxString>{"email": "".obs, "password": "".obs}.obs;
  var isReady = false.obs;
  var authStatus = AuthStatus.checking.obs;

  // Storage
  final GetStorage _box = GetStorage();
  final LocalStorageService _localStorageService = Get.find();
  final ApiService _apiService = Get.find();

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

  /// process login
  Future<void> processLogin(String emailInput, String passwordInput) async {
    try {
      clearErrorsMessage();

      final response = await _apiService.login(emailInput, passwordInput);
      final result = response.data;
      if (response.statusCode == 200) {
        final token = result['token'];
        var user = User.fromJson(result['data']);
        _localStorageService.saveUserInfo(user, token);

        userInfo.value = user;
        isLogin.value = true;

        /// auto redirect to home
        /// Get.offAllNamed(AppRoutes.index);
        authStatus.value = AuthStatus.authenticated;
      } else {
        final message = result['message'] ?? "Login failed";
        errors['email']?.value = message;
        errors['password']?.value = message;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response?.data['message'] ?? "Login failed";
        errors['email']?.value = message;
        errors['password']?.value = message;
      } else {
        errors['email']?.value = "Network error, please try again.";
      }
    } catch (e) {
      errors['email']?.value = "Something went wrong.";
    } finally {}
  }

  /// check authentication
  Future<void> _checkAuth() async {
    final token = _localStorageService.readToken();
    if (token == null) {
      isReady.value = true;
      authStatus.value = AuthStatus.unauthenticated;
      return;
    }

    try {
      isReady.value = false;
      final response = await _apiService.authentication(token);
      final result = response.data;

      if (response.statusCode == 200) {
        if (result["status"] == 200) {
          var user = User.fromJson(result['data']);
          userInfo.value = User.fromJson(result['data']);
          isLogin.value = true;
          authStatus.value = AuthStatus.authenticated;
        } else {
          authStatus.value = AuthStatus.unauthenticated;
        }
      }
    } on DioException catch (e) {
      authStatus.value = AuthStatus.unauthenticated;
    } catch (e) {
      authStatus.value = AuthStatus.unauthenticated;
    } finally {
      isReady.value = true;
    }
  }

  /// LOGOUT
  void processLogout() {
    var keys = ["_token", "tags", "notes", "user_info"];
    for (String key in keys) {
      _localStorageService.clearFromStorage(key);
    }
    isLogin.value = false;
    isReady.value = true;
    userInfo.value = null;
    authStatus.value = AuthStatus.unauthenticated;
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
