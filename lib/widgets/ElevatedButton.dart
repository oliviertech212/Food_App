import 'package:flutter/material.dart';

import 'package:foodapp/utils/colors.dart';

Widget MyElevatedButton(BuildContext context, height, text, click, isloading) {
  return SizedBox(
      height: height as double,
      // width: width,
      child: ElevatedButton(
        onPressed: () {
          click();
        },
        style: ElevatedButton.styleFrom(
          primary: AppColors.bgprimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: isloading
            ? CircularProgressIndicator(
                color: AppColors.textWhitecolor,
              )
            : Text(
                text,
                style: TextStyle(
                  color: AppColors.textWhitecolor,
                  fontSize: 30,
                ).copyWith(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
      ));
}
