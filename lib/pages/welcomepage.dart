import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/functions/firebaseauthentication.dart';
import 'package:foodapp/models/cart.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/services/stateMngt/wishlist.provider.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:foodapp/widgets/Title.dart';
import 'package:foodapp/widgets/productDialog.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

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

  // int totalcartItems(List items, int id) {
  //   int similarItem =
  //       items.where((element) => element.id == id).toList().length;
  //   return similarItem;
  // }
  void addToCart(BuildContext context, Product product) {
    context.read<CartProvider>().add(product);
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

    //  --access app cart state
    var cartData = context.watch<CartProvider>();
    int totalQuantity = cartData.items;
    List<CartItem> allItems = cartData.allItems;
    // --access app wishlist state
    var wishlistItems = context.watch<WishlistProvider>();
    int totalWishlistItems = wishlistItems.items;
    List<Product> allWishlistItems = wishlistItems.allItems;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            floating: true,
            pinned: true,
            centerTitle: false,
            title: myTitle(context, totalQuantity: totalQuantity),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Home"),
                          value: 1,
                          onTap: () {
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
                        PopupMenuItem(
                            child: Text("Logout"),
                            value: 2,
                            onTap: () async {
                              FirebaseAuthenticationService
                                  firebaseAuthenticationService =
                                  FirebaseAuthenticationService();
                              await firebaseAuthenticationService.signOut();
                              Navigator.pushNamed(context, '/home');
                            }),
                        PopupMenuItem(
                          child: Text("Profile"),
                          value: 3,
                          // onTap: () => Navigator.pushNamed(context, '/profile'),
                        ),
                      ]),
            ],
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
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
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
                        return Column(
                          children: [
                            const Center(child: Text('There are no products')),
                            TextButton(
                                onPressed: () async {
                                  fetchProducts();
                                },
                                child: Text("Reload "))
                          ],
                        );
                      }

                      data = data
                          .where((product) => product.category == id)
                          .toList();
                      print("prooooo $data $id");

                      data.forEach((element) {
                        print("product ${element.name}");
                      });
                      return GridView.builder(
                        // shrinkWrap: true,
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

                          if (text != null && text != '') {
                            if (product?.name
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ==
                                true) {
                              return GestureDetector(
                                  onTap: () {
                                    print('Product image tapped');
                                    if (product != null) {
                                      //  - Show the product details
                                      MySingleProductDialog(context, product);
                                    } else {
                                      print('Product is null');
                                    }
                                  },
                                  child: Card(
                                    clipBehavior: product?.image == null
                                        ? Clip.none
                                        : Clip.antiAliasWithSaveLayer,
                                    child: Column(
                                      children: [
                                        // Product Image
                                        Container(
                                          width: double.infinity,
                                          height: 120,
                                          // margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "${product?.image}"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),

                                        // Product Details
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                'Price: ${product?.price}  Rwf',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                  width: 100,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .add_shopping_cart),
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  CartProvider>()
                                                              .add(product!);
                                                        },
                                                      ),
                                                      Text(
                                                          "${context.read<CartProvider>().totalSimilarItems(product!.id)}"),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                            return Container();
                          }

                          return GestureDetector(
                              onTap: () {
                                print('Product image tapped');
                                if (product != null) {
                                  //  - Show the product details
                                  MySingleProductDialog(context, product);
                                } else {
                                  print('Product is null');
                                }
                              },
                              child: SizedBox(
                                height: 200.0, // Set the desired height here
                                child: Card(
                                  clipBehavior: product?.image == null
                                      ? Clip.none
                                      : Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    children: [
                                      // Product Image
                                      Container(
                                        width: double.infinity,
                                        height: 120,
                                        // margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage("${product?.image}"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      // Product Details
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              'Price: ${product?.price} Rwf ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Container(
                                                width: 100,
                                                child: Consumer<CartProvider>(
                                                  builder: (context,
                                                          cartProvider,
                                                          child) =>
                                                      Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: IconButton(
                                                          icon: Icon(Icons
                                                              .add_shopping_cart),
                                                          onPressed: () {
                                                            cartProvider
                                                                .add(product!);
                                                          },
                                                        ),
                                                      ),
                                                      Text(
                                                          "${cartProvider.totalSimilarItems(product!.id)}"),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          final wishlistProvider =
                                                              context.read<
                                                                  WishlistProvider>();
                                                          if (allWishlistItems
                                                              .contains(
                                                                  product)) {
                                                            wishlistProvider
                                                                .removeProduct(
                                                                    product);
                                                          } else {
                                                            wishlistProvider
                                                                .addProduct(
                                                                    product);
                                                          }
                                                        },
                                                        icon: Icon(
                                                          allWishlistItems
                                                                  .contains(
                                                                      product)
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
