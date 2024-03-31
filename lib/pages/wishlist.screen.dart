import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/services/stateMngt/wishlist.provider.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/PopupMenu.dart';
import 'package:foodapp/widgets/Title.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    var wishlistItems = context.watch<WishlistProvider>();
    int totalWishlistItems = wishlistItems.items;
    List<Product> allItems = wishlistItems.allItems;

    //  --access app cart state
    var cartData = context.watch<CartProvider>();
    int totalQuantity = cartData.items;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: myTitle(context, totalQuantity: totalQuantity),
        // -- handle add menu icon
        actions: [MyPopUpMenu(context)],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgSecondary,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Wishlist',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400, // height of the container
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: allItems.map((product) {
                  return Card(
                    margin: EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.backgroundWhite,
                          )),
                      width: 180, //  width of the card
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Image.asset(
                              product.image,
                              height: 200, //  height of the image
                              width: 180, //  width of the image
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
                                IconButton(
                                  onPressed: () {
                                    final wishlistProvider =
                                        context.read<WishlistProvider>();
                                    if (wishlistProvider.allItems
                                        .contains(product)) {
                                      wishlistProvider.removeProduct(product);
                                    } else {
                                      wishlistProvider.addProduct(product);
                                    }
                                  },
                                  icon: Icon(
                                    wishlistItems.allItems.contains(product)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Price:${product.price} Rwf',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green), // font size
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.backgroundWhite,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          elevation: 8.0,
          selectedItemColor: AppColors.bgprimaryColor,
          backgroundColor: AppColors.bgSecondary,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/wishlist');
                },
                icon: const Icon(Icons.favorite_border_outlined),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: const Icon(Icons.home_outlined),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                icon: const Icon(Icons.person_outline),
              ),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: IconButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, '/cart');
            //       },
            //       icon: const Icon(Icons.shopping_basket_outlined)),
            //   label: '',
            // )
          ],
        ),
      ),
    );
  }
}
