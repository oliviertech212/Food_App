import 'package:flutter/material.dart';
import 'package:foodapp/models/cart.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';
import 'package:provider/provider.dart';


class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
double get totalPrice {
  var cartData = context.watch<CartProvider>();
  List<CartItem> allItems = cartData.allItems;
  return allItems.fold(0.0, (total, item) => total + (num.parse(item.price) * item.quantity.toDouble()));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Checkout'),
            const SizedBox(height: 10.0),
            _buildOrderDetails(),
            const SizedBox(height: 10.0),
            _buildUseSavedAddress(),
            const SizedBox(height: 10.0),
            _buildShippingDetails(),
            const SizedBox(height: 10.0),
            _buildSpecialNotes(),
            const SizedBox(height: 10.0),
            _buildPayNowButton(),
            const SizedBox(height: 10,),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
  //widget for build order details
  Widget _buildOrderDetails() {
    var cartData = context.watch<CartProvider>();
    List<CartItem>allItems = cartData.allItems;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Your Order Details'),
            ...allItems.map((item) =>
            Row(
              children: [
                Text(item.name),
                Spacer(),
                Text('${item.price }Rwf/1'),
                Spacer(),
                Text('Quantity: ${item.quantity}')
              ],
            )).toList(),
            SizedBox(height: 5,),
             Divider(),
             Text('Total price: ${totalPrice.toString()}Rwf'),
             SizedBox(height: 10,),
          ],
        ),
    )
    );
  }

  // Widget to build the "Use Saved Address" section
  Widget _buildUseSavedAddress() {
    bool _useSavedAddress = false;
    return Row(
      children: [
        Checkbox(
          value: _useSavedAddress,
          onChanged: (bool? newValue) {
            setState(() {
              _useSavedAddress = newValue ?? false;
            });
          },
        ),
        Text('Use Saved Address'),
      ],
    );
  }

  // Widget to build the "Shipping Details" section
  Widget _buildShippingDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Shipping Details',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Text fields for house number, phone number, etc.
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: AppColors.textPrimarycolor),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      hintText: 'House No',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.textPrimarycolor)
                      )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'please enter your house no';
                      }
                      return null;
                    },
                  ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextFormField(
                    style: TextStyle(color: AppColors.textPrimarycolor,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      hintText: 'Street Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.textPrimarycolor)
                      )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'please enter street name';
                      }
                      return null;
                    },
                  )
                    )
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: AppColors.textPrimarycolor),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      hintText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.textPrimarycolor)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your city';
                      }
                      return null;
                    },
                  ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextFormField(
                    style: TextStyle(color: AppColors.textPrimarycolor),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      hintText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.textPrimarycolor)
                      )
                    ),
                    validator: (value) {
                      if (value ==null || value.isEmpty){
                        return 'please enter phone number';
                      }
                      return null;
                    },
                  )
                    )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget to build the "Special Notes" section
  Widget _buildSpecialNotes() {
    return Card(
      child:  TextField(
      decoration: InputDecoration(
        labelText: 'Special Notes for delivery',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    )
    );
  }

  // Widget to build the "Pay Now" button
  Widget _buildPayNowButton() {
    return MyElevatedButton(
      context, 
      40.0, 
      'Pay Now', 
      () {}, 
      false);
  }
  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(
      backgroundColor: AppColors.bgSecondary,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.home_outlined)
            ),
          label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              }, 
              icon: Icon(Icons.person_outline),
              ),
              label: 'profile'
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mainpagecategory');
                }, 
                icon: Icon(Icons.shopping_basket_outlined)
                ),
                label: 'add product'
              )
      ]
      );
  }
}