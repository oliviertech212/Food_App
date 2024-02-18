import 'package:flutter/material.dart';

import 'package:foodapp/utils/colors.dart';

Widget MyElevatedButton(BuildContext context, height, text, click) {
  return SizedBox(
      height: height,
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
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.textWhitecolor,
            fontSize: 18,
          ).copyWith(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}
