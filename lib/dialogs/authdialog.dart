import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';

Future ErrorDialog(String errorCode, BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          clipBehavior: Clip.none,
          backgroundColor: AppColors.backgroundWhite,
          title: const Text("An error occurred",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Roboto')),
          content: Text("$errorCode",
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Roboto')),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Roboto')))
          ],
        );
      });
}
