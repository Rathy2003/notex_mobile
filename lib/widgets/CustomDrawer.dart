import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notex_mobile/controllers/AuthController.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _authController.userInfo.value!.profile.safeProvider,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _authController.userInfo.value!.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _authController.userInfo.value!.email,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
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
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favorites'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/favorites');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Trash'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/trash');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/settings');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    // Add logout logic here
                  },
                ),
              ],
            ),
          ),
          
          // Footer
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
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
