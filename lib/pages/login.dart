import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ourbrandname.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
            height: 200,
            width: double.infinity,
            child: brandName(context),
          ),
            
             TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: AppColors.textPrimarycolor,
                
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.bgprimaryColor,
                )
              )
              ),
            ),
            const SizedBox(height: 20),
             TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: AppColors.textPrimarycolor,
                
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.bgprimaryColor,
                )
              )
              ),
              ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {}, 
              child: Text('forgot password?',
              style: TextStyle(
                color: AppColors.textPrimarycolor,
                fontWeight: FontWeight.bold,

                ),
              ),
              ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: AppColors.bgprimaryColor,
              ), 
              child: Text('Eat Away!',
              style: TextStyle(
                color: AppColors.textWhitecolor,
                fontWeight: FontWeight.bold,
              ),
              ),
              ),
              const SizedBox(height: 20),
              Column(
  children: <Widget>[
    const Text('or Sign in with'),
    const SizedBox(height: 10),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.email),
          onPressed: () {
            //  email sign in
          },
        ),
        IconButton(
          icon: const Icon(Icons.facebook),
          onPressed: () {
            // Facebook sign in
          },
        ),
      ],
    ),
  ],
),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.bgprimaryColor,),
                 child: Text('sign up',
                 style: TextStyle(
                   color: AppColors.textWhitecolor,
                   fontWeight: FontWeight.bold,
                  ),
              ),
           ),
          ],
        ),
      ),
      
    );
  }
}
