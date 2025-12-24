import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/utils/color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    AuthController authController = Get.find();
    var _email = TextEditingController(text: "");
    var _password = TextEditingController(text: "");
    final font  = GoogleFonts.poppins().fontFamily;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Obx(()=> authController.isReady.value ? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Text(
                "Login to your account.",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontFamily: font,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Welcome back you've\nbeen missed!",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: font,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 55,),
              // Email Text Field
              Obx(()=> TextField(
                controller: _email,
                onChanged: (value) => {
                  authController.errors["email"].toString() != "" ? authController.clearErrorsMessage() : null
                },
                style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: font,
                    fontSize: 18
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red
                        )
                    ),
                    errorText: authController.errors['email'].toString() == "" ? null : "",
                    hintText: "Email Address",
                    filled: true,
                    fillColor: AppColors.secondaryColor
                ),
              ),
              ),
          
              Obx(()=> authController.errors['email'].toString() != "" ?  Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    authController.errors['email'].toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 17
                    ),
                  )
              ) : SizedBox.shrink()),
          
          
              SizedBox(height: 45,),
              // Password Text Field
              Obx(() => TextField(
                controller: _password,
                obscureText: true,
                style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: font,
                    fontSize: 18
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red
                        )
                    ),
                    errorText: authController.errors['password'].toString() != "" ? "" : null,
                    hintText: "Password",
                    filled: true,
                    fillColor: AppColors.secondaryColor
                ),
              ),),
          
              // Sign In Button
              SizedBox(height: 45,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ElevatedButton(
                    onPressed: ()=> authController.processLogin(_email.text, _password.text),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
          
                    ),
                    child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 19,
                            fontFamily: font,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        )
                    )
                ),
              ),
              SizedBox(height: 15,),
            ],
          ),
        ) : SizedBox.shrink()),
      ),
    );
  }
}

