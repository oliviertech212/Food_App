import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/services/stateMngt/wishlist.provider.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/Title.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    //  --access app cart state
    var wishlistItems = context.watch<WishlistProvider>();
    int totalWishlistItems = wishlistItems.items;
    List<Product> allItems = wishlistItems.allItems;

    allItems.forEach((element) => print(
        "items in wishlist${element.name} ${element.price} ${element.image}"));

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: myTitle( context, totalQuantity: totalWishlistItems),
          // backgroundColor: AppColors.backgroundWhite,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.backgroundWhite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(allItems[index].image),
                      title: Row(
                        children: [
                          Expanded(child: Text(allItems[index].name)),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              // code to decrease the quantity of the product
                              context.read<WishlistProvider>().removeProduct(allItems[index]);
                            },
                          ),
                          Text(
                              '${allItems[index].price} Rwf'), // display the quantity here
                        ],
                      ),
                      subtitle: Text('${allItems[index].price} Rwf'),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
