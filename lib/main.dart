import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/pages/home.dart';
import 'package:foodapp/pages/login.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:foodapp/utils/theme.dart';
import 'package:foodapp/pages/signup.dart';
import 'package:foodapp/pages/forgot_password.dart';
import 'package:foodapp/pages/verification.dart';
import 'package:foodapp/pages/new_password.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path_provider/path_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized

  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   sqfliteFfiInit();
  //   databaseFactory = databaseFactoryFfi;
  // }

  // printDatabaseVersion() async {
  //   final version = await DatabaseeService().getDatabaseVersion();
  //   return 'Database version: $version';
  // }

  // printDatabaseVersion();

  try {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    } else if (kIsWeb) {
      // Use databaseFactoryFfiWeb for web
      databaseFactory = databaseFactoryFfiWeb;
    }

    // Get database version (and create table if necessary)
    final version = await DatabaseeService().getDatabaseVersion();
    print('Database version: $version');

    runApp(const FoodApp());
  } catch (error) {
    print('Error initializing database: $error');
    // Handle database initialization errors gracefully
  }

  // databaseFactory = databaseFactoryFfiWeb; // Use databaseFactoryFfiWeb for web
  runApp(const FoodApp());
}

// Future main() async {
//   sqfliteFfiInit();

//   databaseFactory = databaseFactoryFfi;
//   runApp(const FoodApp());
// }

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: foodApptheme,
      title: 'welcome',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const MySignupPage(),
        '/forgot-password': (context) => ForgotPassword(),
        '/verification': (context) => const verification(),
        '/new-password': (context) => const NewPassword(),
      },
    );
  }
}
