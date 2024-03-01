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
  // final userDB = UserDB();
  final table = DatabaseService();
  Future<List<Product>>? futureallproducts;

  // Future<String> getpath() async {
  //   final fullPath =  DatabaseService(); // Await the full path
  //   print('path: $fullPath');
  //   return fullPath;
  // }

  void initState() {
    super.initState();
    // fetchusers();
    table.initialize().then((_) {
      fetchusers();
    });
  }

  void fetchusers() async {
    // Check for database initialization
    if (table.database == null) {
      throw Exception(" on homepage Database not initialized");
    }
    setState(() {
      // table.insertAdmin();
      // table.insertProducts();
      futureUsers = table.getUsers();
      futureallproducts = table.getAllproduct();
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
          return Center(child: CircularProgressIndicator());
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
            itemBuilder: (context, userIndex) {
              final userProducts = products
                  .where((product) => product.sellerId == users[userIndex].id)
                  .toList();
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('User: ${users[userIndex].username ?? ''}'),
                      subtitle: Text('Email: ${users[userIndex].email}'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: userProducts.length,
                      itemBuilder: (context, productIndex) {
                        final product = userProducts[productIndex];
                        return ListTile(
                          title: Text('Product: ${product.name ?? ''}'),
                          // title: Text('Product: ${product.image ?? ''}'),
                          subtitle: Text('Price: ${product.price}'),
                          leading: Container(
                            width: 80, // Adjust the width as needed
                            child: Image(
                              image: AssetImage(product.image ?? ''),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Text(
                                  "Image loading failed"), // Or a custom error widget
                            ),
                          ),
                        );
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
