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
    final currentRoute = Get.currentRoute;
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
                _buildItem(
                  context,
                  icon: Icons.home,
                  label: 'home'.tr,
                  route: '/index',
                  currentRoute: currentRoute,
                ),
                _buildItem(
                  context,
                  icon: Icons.settings,
                  label: 'setting'.tr,
                  route: '/setting',
                  currentRoute: currentRoute,
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: EdgeInsets.all(15),
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

Widget _buildItem(
  BuildContext context, {
  required IconData icon,
  required String label,
  required String route,
  required String currentRoute,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final isActive = currentRoute == route;
  final color = isActive ? (isDark ? Colors.black : Colors.white) : null;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    decoration: BoxDecoration(
      color:
          isActive
              ? (isDark ? Colors.white : Colors.black)
              : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: color,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Get.toNamed(route);
      },
    ),
  );
}
