import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:notex_mobile/screens/setting_screen.dart';

class CustomDrawer extends StatelessWidget {
  // const CustomDrawer({
  //   super.key,
  // });

  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        _authController.userInfo.value!.profile.safeProvider,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _authController.userInfo.value!.username,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _authController.userInfo.value!.email,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('home'.tr),
                  onTap: () {
                    Get.toNamed('/index');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('setting'.tr),
                  onTap: () {
                    Get.toNamed('/setting');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('logout'.tr, style: TextStyle(color: Colors.red)),
                  onTap: () => authController.processLogout(),
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// Extension for safe image provider
extension SafeImageProvider on String? {
  ImageProvider get safeProvider {
    var noProfileImage = "assets/images/no_profile.jpg";
    if (this == null || this!.isEmpty) {
      return AssetImage(noProfileImage);
    }

    try {
      final uri = Uri.tryParse(this!);
      if (uri == null || !uri.hasScheme) {
        return AssetImage(noProfileImage);
      }

      return CachedNetworkImageProvider(this!);
    } catch (e) {
      return AssetImage(noProfileImage);
    }
  }
}
