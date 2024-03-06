import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/utils/colors.dart';

class MainpageCategoryScreen extends StatefulWidget {
  const MainpageCategoryScreen({super.key});

  @override
  State<MainpageCategoryScreen> createState() => _MainpageCategoryScreenState();
}
// main menu /  dessert menu / sarad ,best sales

class _MainpageCategoryScreenState extends State<MainpageCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        title: Container(
          // color: Colors.white,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  splashColor: Colors.black,
                  highlightColor: const Color.fromARGB(255, 61, 59, 59),
                  icon: const Icon(Icons.shopping_basket, color: Colors.black),
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "Welcome",
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ).copyWith(
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              "  Homemade meals prepared with love.  ",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors.textWhitecolor,
                  ),
            ),
            Text(
              "  Richest ingredients. ",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors.textWhitecolor,
                  ),
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: Form(
                  child: TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              )),
            ),
            SingleChildScrollView(
                child: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20), // Small rounded corners at the top
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Form(
                        child: TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Form(
                        child: TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Form(
                        child: TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Form(
                        child: TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Form(
                        child: TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Form(
                        child: TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Form(
                        child: TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                  ),
                ],
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
