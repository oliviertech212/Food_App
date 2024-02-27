import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/models/users.dart';
import 'package:foodapp/services/users.dart';
import 'package:foodapp/services/database_service.dart';

//  /data/user/0/com.example.foodapp/databases/wedeliverfoodapp.db
// sdk location /home/tech/Android/Sdk
// >adb devices
// connect to attached emmulator
// adb -s emulator-5554 shell

class MyWelcomePage extends StatefulWidget {
  const MyWelcomePage({super.key});

  @override
  State<MyWelcomePage> createState() => _MyWelcomePageState();
}

class _MyWelcomePageState extends State<MyWelcomePage> {
  Future<List<User>>? futureUsers;
  final userDB = UserDB();

  Future<String> getpath() async {
    final fullPath = await DatabaseeService().fullpath; // Await the full path
    print('path: $fullPath');
    return fullPath;
  }

  @override
  void initState() {
    super.initState();
    fetchusers();
  }

  void fetchusers() {
    setState(() {
      futureUsers = userDB.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    getpath();

    // print('Welcome Pageff $futureUsers path: ret$path');
    return FutureBuilder(
        future: futureUsers,
        builder: (context, snapshot) {
          print('user $futureUsers');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final users = snapshot.data;
            if (users == null || users.isEmpty) {
              return const Text('No Users');
            }
            return ListView.builder(
              itemCount: users?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(users[index].username ?? ''),
                    subtitle: Text(users[index].email),
                  ),
                );
              },
            );
          }
        });
  }
}
