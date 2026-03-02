import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/utils/color.dart';
import 'package:notex_mobile/widgets/CustomButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final _email = TextEditingController();
    final _password = TextEditingController();
    const font = "Poppins";

    OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color, width: 1.5),
        );

    final inputTextStyle = const TextStyle(
      fontFamily: font,
      fontSize: 16
    );

    // Keep TextFields static except where needed
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Hero(tag: "logo", child: Image.asset("assets/icon/icon.png", height: 100)),
              const SizedBox(height: 50),

              /// EMAIL FIELD
              TextField(
                controller: _email,
                onChanged: (value) {
                  authController.email.value = value;
                  if (authController.errors['email']!.value != "") {
                    authController.clearErrorsMessage();
                  }
                },
                style: inputTextStyle,
                decoration: InputDecoration(
                  hintText: "email".tr,
                  filled: true,
                  fillColor: AppColors.secondaryColor,
                  border: inputBorder(Colors.grey),
                  focusedBorder: inputBorder(Colors.blue),
                  errorBorder: inputBorder(Colors.red),
                ),
              ),

              Obx(() => authController.errors['email']!.value != ""
                  ? Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        authController.errors['email']!.value,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 20),

              /// PASSWORD FIELD
              Obx(() => TextField(
                    controller: _password,
                    obscureText: authController.isPasswordHidden.value,
                    onChanged: (value) {
                      authController.password.value = value;
                      if (authController.errors['password']!.value != "") {
                        authController.clearErrorsMessage();
                      }
                    },
                    style: inputTextStyle,
                    decoration: InputDecoration(
                      hintText: "password".tr,
                      filled: true,
                      fillColor: AppColors.secondaryColor,
                      border: inputBorder(Colors.grey),
                      focusedBorder: inputBorder(Colors.blue),
                      errorBorder: inputBorder(Colors.red),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authController.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: authController.isPasswordHidden.toggle,
                      ),
                    ),
                  )),

              Obx(() => authController.errors['password']!.value != ""
                  ? Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        authController.errors['password']!.value,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 40),

              /// SIGN IN BUTTON
              Obx(() {
                final isEnabled =
                    authController.email.value.isNotEmpty &&
                    authController.password.value.isNotEmpty;

                return CustomButton(
                  label: "sign_in".tr,
                  onPressed: isEnabled
                      ? () => authController.processLogin(
                            authController.email.value,
                            authController.password.value,
                          )
                      : null,
                  gradient: isEnabled
                      ? const LinearGradient(
                          colors: [Colors.blue, Colors.lightBlueAccent])
                      : null,
                );
              }),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}