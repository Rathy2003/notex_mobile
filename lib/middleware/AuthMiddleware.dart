import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/route/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthController controller = Get.find();
    if(!controller.isLogin.value){
      return RouteSettings(name: AppRoutes.login);
    }else if(route == AppRoutes.login){
      return RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}