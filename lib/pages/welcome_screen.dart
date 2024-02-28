import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/models/users.dart';
import 'package:foodapp/services/product_table.services.dart';
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
  Future<List<Product>>? futureallproducts;
  final produstTable = ProductTable();

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
      futureallproducts = produstTable.getAllproduct();
    });
  }

//      //- handle multiple Future in single widget
//     Future<dt> fetchData() async {
//   await Future.wait([ futureUsers, futureallproducts]);
// }

//   @override
//   Widget build(BuildContext context) {
//     getpath();

//     // print('Welcome Pageff $futureUsers path: ret$path');
//     return FutureBuilder<List<dynamic>>(
//         // future: futureUsers,
//         // future: futureallproducts,
//         future:
//             Future.wait([futureUsers as dynamic, futureallproducts as dynamic]),
//         builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//           print('user $futureUsers');

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             // final users = snapshot.data;

//             final List<dynamic> data = snapshot.data as dynamic;
//             final List<User> users = data[0];
//             final List<Product> products = data[1];
//             if (users == null ||
//                 users.isEmpty ||
//                 products == null ||
//                 products.isEmpty) {
//               return Text('No Users or Products');
//             }
//             print("product${products}");
//             return ListView.builder(
//               itemCount: users?.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(users[index].username ?? ''),
//                     subtitle: Text(users[index].email),
//                   ),
//                 );
//               },
//             );
//           }
//         });
//   }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future:
          Future.wait([futureUsers as dynamic, futureallproducts as dynamic]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<dynamic> data = snapshot.data as dynamic;
          final List<User> users = data[0];
          final List<Product> products = data[1];

          if (users == null ||
              users.isEmpty ||
              products == null ||
              products.isEmpty) {
            return Text('No Users or Products');
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('User: ${users[index].username ?? ''}'),
                      subtitle: Text('Email: ${users[index].email}'),
                    ),
                    // Display product information related to this user
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        // Check if the product is related to the current user

                        if (products[index].sellerId == users[index].id) {
                          return ListTile(
                            title: Text("${products.length}"),
                            // title:
                            //     Text('Product: ${products[index].name ?? ''}'),
                            subtitle: Text('Price: ${products[index].price}'),
                            leading: Container(
                              width: 80, // Adjust the width as needed
                              child: Image.network(
                                products[index].image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Text(
                                    "Image loading failed"), // Or a custom error widget
                              ),
                            ),
                          );
                        } else {
                          return SizedBox
                              .shrink(); // Empty widget if product is not related to this user
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
