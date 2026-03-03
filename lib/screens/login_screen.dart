// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:notex_mobile/controllers/AuthController.dart';
// import 'package:notex_mobile/utils/color.dart';
// import 'package:notex_mobile/widgets/CustomButton.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthController _authController = Get.find();
//     final _email = TextEditingController();
//     final _password = TextEditingController();
//     const font = "Poppins";

//     OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: BorderSide(color: color, width: 1.5),
//     );

//     final inputTextStyle = const TextStyle(fontFamily: font, fontSize: 16);

//    return Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 60),
//                 Hero(
//                   tag: "logo",
//                   child: Image.asset("assets/icon/icon.png", height: 100),
//                 ),
//                 const SizedBox(height: 50),

//                 /// EMAIL FIELD
//                 TextField(
//                   controller: _email,
//                   onChanged: (value) {
//                     _authController.email.value = value;
//                     if (_authController.errors['email']!.value != "") {
//                       _authController.clearErrorsMessage();
//                     }
//                   },
//                   style: inputTextStyle,
//                   decoration: InputDecoration(
//                     hintText: "email".tr,
//                     filled: true,
//                     fillColor: AppColors.secondaryColor,
//                     border: inputBorder(Colors.grey),
//                     focusedBorder: inputBorder(Colors.blue),
//                     errorBorder: inputBorder(Colors.red),
//                   ),
//                 ),

//                 Obx(
//                   () =>
//                       _authController.errors['email']!.value != ""
//                           ? Container(
//                             alignment: Alignment.centerLeft,
//                             margin: const EdgeInsets.only(top: 5),
//                             child: Text(
//                               _authController.errors['email']!.value,
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           )
//                           : const SizedBox.shrink(),
//                 ),
//                 const SizedBox(height: 20),

//                 /// PASSWORD FIELD
//                 Obx(
//                   () => TextField(
//                     controller: _password,
//                     obscureText: _authController.isPasswordHidden.value,
//                     onChanged: (value) {
//                       _authController.password.value = value;
//                       if (_authController.errors['password']!.value != "") {
//                         _authController.clearErrorsMessage();
//                       }
//                     },
//                     style: inputTextStyle,
//                     decoration: InputDecoration(
//                       hintText: "password".tr,
//                       filled: true,
//                       fillColor: AppColors.secondaryColor,
//                       border: inputBorder(Colors.grey),
//                       focusedBorder: inputBorder(Colors.blue),
//                       errorBorder: inputBorder(Colors.red),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _authController.isPasswordHidden.value
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                         ),
//                         onPressed: _authController.isPasswordHidden.toggle,
//                       ),
//                     ),
//                   ),
//                 ),

//                 Obx(
//                   () =>
//                       _authController.errors['password']!.value != ""
//                           ? Container(
//                             alignment: Alignment.centerLeft,
//                             margin: const EdgeInsets.only(top: 5),
//                             child: Text(
//                               _authController.errors['password']!.value,
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           )
//                           : const SizedBox.shrink(),
//                 ),
//                 const SizedBox(height: 40),

//                 /// SIGN IN BUTTON
//                 Obx(() {
//                   final isEnabled =
//                       _authController.email.value.isNotEmpty &&
//                       _authController.password.value.isNotEmpty;

//                   return CustomButton(
//                     label: "sign_in".tr,
//                     onPressed:
//                         isEnabled
//                             ? () => _authController.processLogin(
//                               _authController.email.value,
//                               _authController.password.value,
//                             )
//                             : null,
//                     gradient:
//                         isEnabled
//                             ? const LinearGradient(
//                               colors: [Colors.blue, Colors.lightBlueAccent],
//                             )
//                             : null,
//                   );
//                 }),
//                 const SizedBox(height: 15),
//               ],
//             ),
//           ),
//         ),
//       );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/utils/color.dart';
import 'package:notex_mobile/widgets/CustomButton.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  OutlineInputBorder _inputBorder(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 1.5),
      );

  InputDecoration _inputDecoration({
    required String hint,
    String? error,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.secondaryColor,
      border: _inputBorder(Colors.grey),
      focusedBorder: _inputBorder(Colors.blue),
      errorBorder: _inputBorder(Colors.red),
      focusedErrorBorder: _inputBorder(Colors.red),
      errorText: error?.isEmpty == true ? null : error,
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    const font = "Poppins";

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 60),

            /// LOGO
            Hero(
              tag: "logo",
              child: Image.asset(
                "assets/icon/icon.png",
                height: 100,
              ),
            ),

            const SizedBox(height: 50),

            /// EMAIL FIELD
            Obx(() => TextField(
                  onChanged: (value) {
                    controller.email.value = value;
                    controller.clearErrorsMessage();
                  },
                  style: const TextStyle(
                    fontFamily: font,
                    fontSize: 16,
                  ),
                  decoration: _inputDecoration(
                    hint: "email".tr,
                    error: controller.errors['email']?.value,
                  ),
                )),

            const SizedBox(height: 20),

            /// PASSWORD FIELD
            Obx(() => TextField(
                  obscureText: controller.isPasswordHidden.value,
                  onChanged: (value) {
                    controller.password.value = value;
                    controller.clearErrorsMessage();
                  },
                  style: const TextStyle(
                    fontFamily: font,
                    fontSize: 16,
                  ),
                  decoration: _inputDecoration(
                    hint: "password".tr,
                    error: controller.errors['password']?.value,
                    suffix: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.isPasswordHidden.toggle,
                    ),
                  ),
                )),

            const SizedBox(height: 40),

            /// SIGN IN BUTTON
            Obx(() {
              final isEnabled =
                  controller.email.value.isNotEmpty &&
                  controller.password.value.isNotEmpty;

              return CustomButton(
                label: "sign_in".tr,
                onPressed: isEnabled
                    ? () => controller.processLogin(
                          controller.email.value,
                          controller.password.value,
                        )
                    : null,
                gradient: isEnabled
                    ? const LinearGradient(
                        colors: [Colors.blue, Colors.lightBlueAccent],
                      )
                    : null,
              );
            }),
          ],
        ),
      ),
    );
  }
}