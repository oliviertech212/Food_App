import "package:flutter/material.dart";
import "package:foodapp/functions/firebaseauthentication.dart";
import "package:foodapp/utils/colors.dart";

Widget MySideBarMenu(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
    child: Drawer(
        // backgroundColor: AppColors.bgprimaryColor,
        backgroundColor: Theme.of(context).primaryColor,
        // clipBehavior: Clip.none,
        shadowColor: AppColors.colorError,
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).copyWith(
                  fontFamily: 'Roboto',
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            Divider(color: AppColors.textWhitecolor, endIndent: 16, indent: 16),
            ListTile(
              title: Text(
                'Product by Category ',
                style: TextStyle(
                  color: AppColors.textWhitecolor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).copyWith(
                  fontFamily: 'Roboto',
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/mainpagecategory');
              },
            ),
            Divider(color: AppColors.textWhitecolor, endIndent: 16, indent: 16),
            // orders
            ListTile(
              title: Text(
                'Orders',
                style: TextStyle(
                  color: AppColors.textWhitecolor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).copyWith(
                  fontFamily: 'Roboto',
                ),
              ),
              // selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pushNamed(context, '/orders');
              },
            ),

            Divider(color: AppColors.textWhitecolor, endIndent: 16, indent: 16),
            ListTile(
              title: Text(
                'Cart',
                style: TextStyle(
                  color: AppColors.textWhitecolor,
                  fontSize: 18,
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
            Divider(color: AppColors.textWhitecolor, endIndent: 16, indent: 16),
            ListTile(
              title: Text(
                'Wishlist',
                style: TextStyle(
                  color: AppColors.textWhitecolor,
                  fontSize: 18,
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
            Divider(color: AppColors.textWhitecolor, endIndent: 16, indent: 16),
            ListTile(
              title: Text(
                'Reset Password',
                style: TextStyle(
                  color: AppColors.textWhitecolor,
                  fontSize: 18,
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

            Divider(color: AppColors.textWhitecolor, endIndent: 16, indent: 16),

            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.textWhitecolor,
                  fontSize: 18,
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
            Divider(color: AppColors.textWhitecolor, endIndent: 16, indent: 16),
          ],
        )),
  );
}
