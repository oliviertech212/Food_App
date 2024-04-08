import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/functions/firestoreOrders.dart';
import 'package:foodapp/models/order.model.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Orders>? orders; // State variable to store Order objects

  @override
  void initState() {
    super.initState();
    Future<void> fetchOrders() async {
      final data = await getOrders();
      setState(() {
        orders = data;
      });
    }

    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (orders != null)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: orders!.length,
                itemBuilder: (context, index) {
                  final order = orders![index];

                  return ListTile(
                    title: Text('Order ID: ${order.orderId}'),
                    subtitle: Text(
                        '${formatDate(order.createdAt)} - ${order.status}'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(order: order))),
                    ),
                  );
                },
              )
            else
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

// Helper function to format timestamp (replace with your desired formatting)
String formatDate(Timestamp timestamp) {
  final date =
      DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

  return DateFormat('MMMM dd, yyyy - hh:mm:ss a')
      .format(date); // Customize format as needed
}

// OrderDetailsPage to display details of a specific order (replace with actual content)
class OrderDetailsPage extends StatelessWidget {
  final Orders order;

  const OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    // Extract specific order details from the 'order' object based on your data structure
    final orderId = order.orderId;
    final createdAt = formatDate(order.createdAt);
    final status = order.status;
    final userId = order.userId;
    final products = order.products; // Assuming a list of products

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display order details
            Text('Order ID: $orderId'),
            Text('Status: $status'),
            Text('Date: $createdAt'),
            Text('User ID: $userId'),
            Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
            if (products.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index]; // Assuming product structure
                  // final name =
                  //     product['Pname']; // Replace with actual field name
                  // final quantity = product['quantity'];
                  // final price = product['price'];
                  // return ListTile(
                  //   title: Text(name),
                  //   subtitle: Text('Quantity: $quantity - Price: \$$price'),
                  // );
                },
              ),
          ],
        ),
      ),
    );
  }
}
