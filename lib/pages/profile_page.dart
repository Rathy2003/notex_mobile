
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:notex_mobile/route/routes.dart';
import 'package:notex_mobile/utils/color.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/widgets/CustomButton.dart';

// ignore: prefer_typing_uninitialized_variables
var buildContext;

List<Map<String,dynamic>> menuItems = [
  {
    "title":"Edit Profile",
    "icon":FaIcon(FontAwesomeIcons.solidUser),
    "route": AppRoutes.profile_details,
  },
  {
    "title":"Settings",
    "icon":FaIcon(FontAwesomeIcons.gear),
    "routes":AppRoutes.search
  },
  {
    "title":"Sign Out",
    "icon":FaIcon(FontAwesomeIcons.arrowRightFromBracket),
  }
];

final AuthController authController = Get.find();

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    
    final TextEditingController username = TextEditingController(text: authController.userInfo.value!.username);
    final TextEditingController email = TextEditingController(text: authController.userInfo.value!.email);
    return Center(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => checkIsLogout(menuItems[index]),
              title: Text(menuItems[index]["title"]),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: menuItems[index]["icon"],
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: const Color.fromARGB(9, 217, 217, 217),
            thickness: 1,
            height: 5,
          ),
          itemCount: menuItems.length
        ),
      ),
    );
  }
  
  Future<void> checkIsLogout(Map<String, dynamic> menuItem) async {
    if(menuItem["title"] == "Sign Out"){
     await _showLogoutDialog();
    }else{
      Get.toNamed(menuItem["route"]);
    }
  }
}

Future<void> _showLogoutDialog() async {
  final screenWidth = MediaQuery.of(buildContext).size.width;
  return showDialog<void>(
    context: buildContext,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(''),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
        content: SizedBox(
          width: screenWidth,  
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.arrowRightFromBracket,size: 80,),
              SizedBox(height: 15,),
              Text("Are you sure to leave?",style: TextStyle(
                fontSize: 18
              ),),

              SizedBox(height: 20,),
              
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 30),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          bgColor: AppColors.secondaryColor,
                          label: "Cancel",
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: CustomButton(
                          label: "Sign Out",
                          bgColor: AppColors.primaryColor,
                          fgColor: Colors.black,
                          onPressed: (){
                            authController.processLogout();
                          },
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // actions: <Widget>[
        //   TextButton(
        //     child: const Text('Approve'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      );
    },
  );
}