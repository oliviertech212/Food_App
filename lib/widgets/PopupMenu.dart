import 'package:flutter/material.dart';
import 'package:foodapp/functions/firebaseauthentication.dart';

Widget MyPopUpMenu(BuildContext context) {
  return PopupMenuButton(
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Home"),
              value: 1,
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            PopupMenuItem(
              child: Text("Settings"),
              value: 3,
              // onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            PopupMenuItem(
                child: Text("Logout"),
                value: 2,
                onTap: () async {
                  FirebaseAuthenticationService firebaseAuthenticationService =
                      FirebaseAuthenticationService();
                  await firebaseAuthenticationService.signOut();
                  Navigator.pushNamed(context, '/home');
                }),
          ]);
}
