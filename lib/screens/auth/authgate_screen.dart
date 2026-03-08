import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/models/AuthStatusEnum.dart';
import 'package:notex_mobile/screens/home_screen.dart';
import 'package:notex_mobile/screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  final AuthController _auth = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      switch (_auth.authStatus.value) {
        case AuthStatus.checking:
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage("assets/icon/icon.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  // Loading
                  SpinKitFadingCircle(
                    color: isDark ? Colors.white : Colors.black,
                    size: 60,
                  ),
                ],
              ),
            ),
          );

        case AuthStatus.unauthenticated:
          return const LoginScreen();

        case AuthStatus.authenticated:
          return HomeScreen();
      }
    });
  }
}
