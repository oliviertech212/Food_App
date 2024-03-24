import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/cart.model.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/PopupMenu.dart';
import 'package:foodapp/widgets/Title.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
    //  --access app cart state
    var cartData = context.watch<CartProvider>();
    int totalQuantity = cartData.items;
    List<CartItem> allItems = cartData.allItems;

    allItems.forEach((element) => print(
        "items in cart${element.name} ${element.price} ${element.image}"));
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: myTitle(context, totalQuantity: totalQuantity),
          // -- handle add menu icon
          actions: [MyPopUpMenu(context)],
          // backgroundColor: AppColors.backgroundWhite,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0), // Small rounded corners at the top
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        allItems[index].image,
                        fit: BoxFit.cover,
                        height: 50.0,
                        width: 80.0,
                      ),
                      title: Row(
                        children: [
                          Expanded(child: Text(allItems[index].name)),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .decreaseQuantity(index);
                            },
                          ),
                          Text(
                              '${context.read<CartProvider>().totalSimilarItems(allItems[index].id)} qty'), // display the quantity here
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .increaseQuantity(index);
                            },
                          ),
                        ],
                      ),
                      subtitle: Text(
                          '${(int.parse(allItems[index].price)) * context.read<CartProvider>().totalSimilarItems(allItems[index].id)} Rwf'),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
