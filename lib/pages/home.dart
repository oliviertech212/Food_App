import 'package:flutter/material.dart';

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
      backgroundColor: const Color.fromARGB(255, 236, 230, 230),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'WaraChow',
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'WaraChow',
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            'WaraChow',
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            'WaraChow',
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => const FoodApp()),
                // );
              },
              child: const Text('Enter'),
            ),
          ),
        ],
      )),
    );
  }
}
