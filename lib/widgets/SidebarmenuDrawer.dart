import "package:flutter/material.dart";
import "package:foodapp/functions/firebaseauthentication.dart";
import "package:foodapp/utils/colors.dart";

Widget MySideBarMenu(BuildContext context) {
  return Drawer(
      backgroundColor: AppColors.bgprimaryColor,
      clipBehavior: Clip.none,
      elevation: 8.0,
      child: ListView(
        padding: EdgeInsets.only(left: 4.0, top: 30.0),
        children: [
          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          //   child: Text('Drawer Header'),
          // ),
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).copyWith(
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text(
              'Product by Category ',
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).copyWith(
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/mainpagecategory');
            },
          ),
          ListTile(
            title: Text(
              'Cart',
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).copyWith(
                fontFamily: 'Roboto',
              ),
            ),
            // selected: _selectedIndex == 0,
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          ListTile(
            title: Text(
              'Wishlist',
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).copyWith(
                fontFamily: 'Roboto',
              ),
            ),
            // selected: _selectedIndex == 0,
            onTap: () {
              Navigator.pushNamed(context, '/wishlist');
            },
          ),
          ListTile(
            title: Text(
              'Reset Password',
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).copyWith(
                fontFamily: 'Roboto',
              ),
            ),
            // selected: _selectedIndex == 0,
            onTap: () {
              Navigator.pushNamed(context, '/new-password');
            },
          ),

          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ).copyWith(
                fontFamily: 'Roboto',
              ),
            ),
            // selected: _selectedIndex == 0,
            onTap: () async {
              FirebaseAuthenticationService firebaseAuthenticationService =
                  FirebaseAuthenticationService();
              await firebaseAuthenticationService.signOut();
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ));
}
