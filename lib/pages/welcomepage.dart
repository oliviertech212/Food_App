import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';
import 'package:foodapp/services/database_service.dart';

// void _showProductDetails(Product product) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: AppColors.bgSecondarydark,
//         title: Text(product.name),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               product.image,
//               height: 90,
//               width: 90,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Description: ${product.description}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text('Price: \$${product.price}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 )),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePagesState();
}

class _WelcomePagesState extends State<WelcomePage> {
  late Future<List<Product>> futureProduct;
  final table = DatabaseService();
  final searchinput = TextEditingController();
  dynamic text;
  String searchText = '';
  List<Product> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    table.initialize().then((_) => fetchProducts());
  }

  void fetchProducts() async {
    if (table.database == null) {
      throw Exception("Something went wrong with the database intialization");
    }
    setState(() {
      futureProduct = table.getAllproduct();
    });
  }

  settext() {
    setState(() {
      text = searchinput.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // - Get the id from the route
    var id;
    var categoryName;
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args['id'];
      categoryName = args['name'];
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            floating: true,
            pinned: true,
            centerTitle: false,
            title: Container(
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
                      icon: const Icon(Icons.shopping_basket,
                          color: Colors.black),
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(60.0), // You can adjust this value as needed
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250.0,
                  height: 40.0,
                  child: Form(
                    child: TextFormField(
                      // controller: searchinput,
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                      autocorrect: true,
                      style: TextStyle(
                          color: Colors.black), // This will make the text black
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Colors.white, // This will make the background white
                        prefixIcon: Icon(Icons.search,
                            color:
                                Colors.black), // This will add the search icon
                        hintText: "Search",
                        hintStyle: TextStyle(
                            color: Colors
                                .black), // This will make the hint text black
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // This will make the border black
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor), // This will make the border color change to primary color on focus
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "$categoryName",
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
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: FutureBuilder<List<Product>>(
                future: Future.delayed(
                  Duration(seconds: 2),
                  () => futureProduct ?? Future.value([]),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return const Text('There are no  Product ');
                    }

                    data = data
                        .where((product) => product.category == id)
                        .toList();
                    print("prooooo $data $id");

                    data.forEach((element) {
                      print("product ${element.name}");
                    });
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6, // adjust this value as needed
                      ),
                      itemBuilder: (context, index) {
                        var product = data?[index];

                        // Shorten the description to 50 characters
                        String shortDescription =
                            (product?.description?.length ?? 0) <= 50
                                ? product?.description ?? ''
                                : (product?.description?.substring(0, 50) ??
                                        '') +
                                    '...';

                        return Card(
                          child: Column(
                            children: [
                              // Product Image
                              Container(
                                width: double.infinity,
                                height: 100,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("${product?.image}"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // Product Details
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Name
                                    Text(
                                      " ${product?.name}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Product Description
                                    Text(
                                      "${shortDescription}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    // Product Price
                                    Text(
                                      'Price: ${product?.price}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
