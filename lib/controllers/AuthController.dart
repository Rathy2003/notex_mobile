import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/utils/environment.dart';

class AuthController extends GetxController{
  RxBool isLogin = false.obs;
  RxMap<String,dynamic> user_info = <String,dynamic>{}.obs;
  var errors = {
    "email": "".obs,
    "password": "".obs
  }.obs;
  final box = GetStorage();
  RxBool isReady = false.obs;

  @override
  void onInit() async {
    super.onInit();
    var connectivity = await Connectivity().checkConnectivity();
    if(connectivity.contains(ConnectivityResult.none)){
      loadFromLocal();
    }else{
      processCheckAuth();
    }

  }

  processLogin(String email, String password) async{
    if(isValidEmail(email)){
      var body = json.encode({"email":email,"password":password});
      http.post(Uri.parse("${Environment.API_BASE_URL}/user/login"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body
      ).then((rp){
         var result = json.decode(rp.body);
         if(result['status'] == 404){
           errors['email'] = "${result['message']}".obs;
           errors['password'] = "${result['message']}".obs;
         }else if(result['status'] == 200){ // mean login successful
           var token = result['token'];
           box.write("_token", token);
           isLogin.value = true;
           user_info.value = result['data'];
           saveToLocal();
           Get.offAllNamed(AppRoutes.home);
         }
      });
    }else{
      errors['email'] = "Please Provide Valid Email".obs;
    }
  }

  processCheckAuth(){
    if(box.read("_token") != null){
      var token = box.read("_token");
      var body = json.encode({"token":token});
      http.post(Uri.parse("${Environment.API_BASE_URL}/user/auth"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body
      ).then((rp){
        var result = json.decode(rp.body);
        if(result['status'] == 200){
         user_info.value = result['data'];
         isLogin.value = true;
         Get.offAllNamed(AppRoutes.home);
        }else if(result['status'] == 200){ // mean login successful
          var token = result['token'];
          box.write("_token", token);
        }

      });
    }else{
      isReady.value = true;
    }
  }

  processLogout(){
    box.remove("_token");
    box.remove("tags");
    box.remove("notes");
    box.remove("user_info");
    isLogin.value = false;
    isReady.value = true;
    Get.offAllNamed(AppRoutes.login);
  }

  clearErrorsMessage(){
    errors['email'] = "".obs;
    errors['password'] = "".obs;
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    );
    return emailRegex.hasMatch(email);
  }

  saveToLocal(){
    box.write("user_info", json.encode(user_info));
  }

  loadFromLocal(){
    if(box.read("user_info") != null){
      var user = json.decode(box.read("user_info"));
      isLogin.value = true;
      user_info.value = user;
      Get.offAllNamed(AppRoutes.home);
    }else{
      isReady.value = true;
    }
  }
}