import 'package:flutter/material.dart';
import 'package:foodapp/widgets/ourbrandname.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //- TextStyle? style = Theme.of(context).textTheme.bodyText1;
    // TextStyle? style1 = Theme.of(context).textTheme.bodyText2;
    // TextStyle? style2 = Theme.of(context).textTheme.subtitle1;
    // TextStyle? style3 = Theme.of(context).textTheme.subtitle1;

    // print(
    //     'Font Family: ${style?.fontFamily} ${style1?.fontFamily}${style2?.fontFamily}${style3?.fontFamily}');
    // print(
    //     'Font Weight: ${style?.fontWeight}  ${style1?.fontWeight}  ${style2?.fontWeight}  ${style3?.fontWeight} ');

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // transparent white at the top
              Colors.black, // black at the bottom
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: brandName(context),
              ),
              Text(
                'Welcome to WaraChow',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                '      Order the best meals in Kigali and ',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                'have them delivered to your doorstep ',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                'in little or notime. Doesnt that sound ',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                '         delicious? ',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: MyElevatedButton(context, 50.0, "next", () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
