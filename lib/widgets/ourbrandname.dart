import 'package:flutter/material.dart';

import 'package:foodapp/utils/colors.dart';

Widget brandName(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('WeDeliver',
              style: TextStyle(
                color: AppColors.textPrimarycolor,
                fontFamily: 'Roboto',
                fontSize: 55,
                fontWeight: FontWeight.bold,
              )),
          Text(
            'on time with WeDeliver',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ));
}

class MyTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final dynamic maxLength;

  final inputControl;
  const MyTextField({
    Key? key,
    required this.labelText,
    required this.inputControl,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          focusColor: AppColors.bgprimaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: AppColors.bgprimaryColor),
          ),
          filled: true,
          // fillColor: AppColors.bgSecondary,
          labelText: labelText,
          labelStyle: TextStyle(
            color: AppColors.textPrimarycolor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.all(20)),
      controller: inputControl,
      // - optional parameter for password field
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
    );
  }
}

 

// "Delight your taste buds with delicious food delivered right on time with WeDeliver. Experience the joy of perfectly-timed meals at your doorstep."