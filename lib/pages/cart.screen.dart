import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/cart.model.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/utils/colors.dart';
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
                              // code to decrease the quantity of the product
                            },
                          ),
                          Text(
                              '${context.read<CartProvider>().totalSimilarItems(allItems[index].id)} qty'), // display the quantity here
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // code to increase the quantity of the product
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
