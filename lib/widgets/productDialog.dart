import 'package:flutter/material.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/services/stateMngt/wishlist.provider.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:provider/provider.dart';

void MySingleProductDialog(BuildContext context, Product product) {
  try {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Access the wishlistProvider inside the builder
        var wishlistProvider = context.watch<WishlistProvider>();
        List<Product> allWishlistItems = wishlistProvider.allItems;
        return Dialog(
          insetPadding: EdgeInsets.zero, // to remove default padding
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              border: Border.all(),
              color: AppColors.backgroundWhite,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  product.image != null
                      ? Image.asset(
                          product.image!,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product name
                        Text(
                          product.name != null ? product.name : '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Product description
                        Text(
                          product.description != null
                              ? product.description
                              : '',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // Product price
                        Text(
                          'Price: ${product.price != null ? product.price : ''} Rwf',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        // Add to cart button
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 150,
                            child: Consumer<CartProvider>(
                              builder: (context, cartProvider, child) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      icon: Icon(Icons.add_shopping_cart),
                                      onPressed: () {
                                        cartProvider.add(product!);
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
                                          context.read<WishlistProvider>();
                                      if (allWishlistItems.contains(product)) {
                                        wishlistProvider.removeProduct(product);
                                      } else {
                                        wishlistProvider.addProduct(product);
                                      }
                                    },
                                    icon: Icon(
                                      allWishlistItems.contains(product)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
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
              Positioned(
                top: 100,
                right: 10,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.colorError)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                        color: AppColors.textWhitecolor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          ),
        );
      },
    );
  } catch (e) {
    print('Error while showing product details: $e');
  }
}
