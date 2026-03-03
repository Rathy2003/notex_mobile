import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/models/AuthStatusEnum.dart';
import 'package:notex_mobile/screens/home_screen.dart';
import 'package:notex_mobile/screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  final AuthController _auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (_auth.authStatus.value) {

        case AuthStatus.checking:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

        case AuthStatus.unauthenticated:
          return const LoginScreen();

        case AuthStatus.authenticated:
          return  HomeScreen();
      }
    });
  }
}