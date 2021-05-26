import 'package:flutter/material.dart';
import 'package:safarkarappfyp/auth/authorisation.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/core/myFonts.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/screens/myPlannerScreen/my_planner_screen.dart';
import 'circlerImageLarge.dart';
import '../../auth/loginScreen/loginScreen.dart';
import 'drawerTile.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CirclerImageLarge(
                  imageUrl: UserLocalData.getUserImageUrl(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    UserLocalData.getUserDisplayName(),
                    style: TextStyle(
                      color: blackShade,
                      fontFamily: englishText,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  // TODO: Import Name from Database
                ),
                Divider(color: Colors.grey),
                DrawerTile(
                  icon: Icons.collections_bookmark_outlined,
                  title: 'My Planners',
                  onPress: () {
                    Navigator.of(context).pushNamed(MyPlannerScreen.routeName);
                  },
                ),
                DrawerTile(
                  icon: Icons.settings,
                  title: 'Settings',
                  onPress: () {},
                ),
                DrawerTile(
                  icon: Icons.report,
                  title: 'Report Problem',
                  onPress: () {},
                ),
              ],
            ),
            DrawerTile(
              icon: Icons.logout,
              title: 'Sign out',
              onPress: () {
                AuthMethods().signOut();
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
