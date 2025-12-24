import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/helpers/hepler.dart';
import 'package:notex_mobile/utils/color.dart';
import 'package:notex_mobile/utils/environment.dart';
import 'package:notex_mobile/widgets/CustomButton.dart';
import 'package:notex_mobile/widgets/CustomTextField.dart';
class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> updateProfileImage(String userId,File file) async {
      final uri = Uri.parse("${Environment.API_BASE_URL}/user/update_profile_photo");
      
      // Create the multipart request
      var request = http.MultipartRequest('POST', uri);
      
      // Add the file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile', // This is the field name your API expects
          file.path,
          filename: file.path.split('/').last, // Extract filename
        ),
      );
      
      // Add other form fields if needed
      request.fields['userId'] = userId ;
      // request.fields['description'] = 'File uploaded from Flutter app';
      
      // // Add headers (e.g., authorization token)
      // request.headers['Authorization'] = 'Bearer your_token_here';
      
      try {
        // Send the request
        final response = await request.send();
        
        // Get response
        final respStr = await response.stream.bytesToString();
        
        if (response.statusCode == 200) {
          print('Upload successful! Response: $respStr');
          // Handle success
        } else {
          print('Upload failed with status: ${response.statusCode}');
          print('Response: $respStr');
          // Handle error
        }
      } catch (e) {
        print('Upload error: $e');
        // Handle exception
      }
    }

    final AuthController authController = Get.find();
    final TextEditingController username = TextEditingController(text: authController.userInfo.value!.username);
    final TextEditingController email = TextEditingController(text: authController.userInfo.value!.email);

    return Scaffold(
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
                // Profile Circle
                Obx((){
                  var profile = authController.userInfo.value!.profile;
                  ImageProvider image = profile != null ? NetworkImage(profile) : AssetImage("assets/images/no_profile.webp"); 
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: AppColors.textColor,
                        backgroundImage: image,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            var pickedFile = await Helper.pickProfileImage();
                            if(pickedFile != null){
                                await updateProfileImage(authController.userInfo.value!.id,pickedFile);
                            }
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.textColorSecondary,
                              borderRadius: BorderRadius.circular(50)
                            ),
                           
                            child: Icon(Icons.camera_alt),
                          ),
                        )
                      )
                    ],
                  );
                }),
                SizedBox(
                  height: 45,
                ),
                CustomTextField(
                  textController: username,
                  hintText: "Username",
                ),
                SizedBox(height: 25,),
                CustomTextField(
                  textController: email,
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
                    Get.defaultDialog(
                      radius: 0,
                    
                      contentPadding: EdgeInsets.zero,
                      titlePadding: EdgeInsets.symmetric(vertical: 25),
                      content: SizedBox(
                        width: Get.width,
                      ),
                      title: "Are you sure to Sign Out?",
                      cancel: CustomButton(label: "Cancel",bgColor: AppColors.textColor,fgColor: Colors.black,),
                      confirm: CustomButton(label: "Sign Out",bgColor: Colors.red,)
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
    );
  }
}