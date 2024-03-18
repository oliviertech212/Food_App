import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';

Widget myTitle(BuildContext context, {totalQuantity}) {
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/wishlist');
          },
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: Text("$totalQuantity",
                    style: TextStyle(
                      color: AppColors.colorError,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    )),
                right: 3.0,
                top: -8.0,
              ),
              IconButton(
                splashColor: Colors.black,
                highlightColor: const Color.fromARGB(255, 61, 59, 59),
                icon: const Icon(Icons.shopping_basket, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ],
          ),
        )
      ],
    ),
  );
}
