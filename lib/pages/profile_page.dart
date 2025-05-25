import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/utils/color.dart';
import 'package:notex_mobile/widgets/BottomNavBar.dart';
import 'package:notex_mobile/widgets/CustomAlertDialog.dart';
import 'package:notex_mobile/widgets/CustomButton.dart';
import 'package:notex_mobile/widgets/CustomTextField.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthController _authController = Get.find();
    final TextEditingController _username = TextEditingController(text: _authController.user_info['username']);
    final TextEditingController _email = TextEditingController(text: _authController.user_info['email']);
    return Center(
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
              onPressed: ()=>Get.back(),
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                color: AppColors.textColor,
              )
          ),
          title: Text(
              "Profile",
              style: TextStyle(
                color: AppColors.textColor
              ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                CustomTextField(
                  textController: _username,
                  hintText: "Username",
                ),
                SizedBox(height: 25,),
                CustomTextField(
                  textController: _email,
                  hintText: "Email Address",
                ),
                SizedBox(
                  height: 25,
                ),
                CustomButton(
                  onPressed: (){

                  },
                  label: "Save Change",
                ),

                SizedBox(height: 25,),
                // Sign Out Button
                CustomButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => CustomAlertDialog(
                        title: "Sign Out?",
                        content: "Are you sure?",
                        cancelLabel: "No",
                        confirmLabel: "Yes",
                        onConfirm: ()=> _authController.processLogout(),
                      ),
                    );
                  } ,
                  bgColor: Colors.red,
                  label: "Sign Out",
                  icon: FaIcon(FontAwesomeIcons.signOut),
                )
              ],
            ),
          )
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
