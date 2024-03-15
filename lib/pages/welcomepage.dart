import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';
import 'package:foodapp/services/database_service.dart';

void main() {
  runApp(WelcomePage());
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePagesState();
}

class _WelcomePagesState extends State<WelcomePage> {
  late Future<List<Product>> futureProduct;
  final table = DatabaseService();

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

  void _showProductDetails(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.bgSecondarydark,
          title: Text(product.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                product.image,
                height: 90,
                width: 90,
              ),
              const SizedBox(height: 10),
              Text(
                'Description: ${product.description}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Price: \$${product.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // - Get the id from the route
    final id =
        ModalRoute.of(context)!.settings.arguments.toString().split(" ")[0];
    final categoryName =
        ModalRoute.of(context)!.settings.arguments.toString().split(" ")[1];

    return FutureBuilder<List<dynamic>>(
      future: Future.delayed(
        Duration(seconds: 2),
        () => futureProduct ?? Future.value([]),
      ),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            // -we neeed something to reload page instead of displaying errors
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No products found.'),
          );
        } else {
          var products = snapshot.data!;
          // Filter products based on category id
          products =
              products.where((product) => product.category == id).toList();

          return Scaffold(
            backgroundColor: AppColors.bgprimaryColor,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: AppColors.textWhitecolor,
                            size: 30,
                          ),
                          onPressed: () {
                            print(' tapped');
                            //if you tapped on menu icon it will take you to the login page
                            Navigator.pushNamed(context, '');
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.textWhitecolor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.textWhitecolor,
                                  blurRadius: 10,
                                ),
                              ]),
                          child: Badge(
                            backgroundColor: AppColors.bgprimaryColor,
                            padding: const EdgeInsets.all(6),
                            child: InkWell(
                              onTap: () {
                                print(' tapped');
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.shopping_basket,
                                    color: AppColors.textPrimarycolor,
                                    size: 30,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: AppColors.bgSecondary,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 12,
                                        minHeight: 12,
                                      ),
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: AppColors.bgSecondarydark,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
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
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${categoryName}',
                          style: TextStyle(
                            color: AppColors.textWhitecolor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '   Find the best selling dishes. All',
                          style: TextStyle(
                            color: AppColors.textWhitecolor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '      meals are prepared fresh.',
                          style: TextStyle(
                            color: AppColors.textWhitecolor,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.textWhitecolor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: AppColors.textWhitecolor,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 100,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Search Menu',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: AppColors.textPrimarycolor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.bgSecondary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // number of items per row
                            crossAxisSpacing:
                                10, // spacing between items horizontally
                            mainAxisSpacing:
                                20, // spacing between items vertically
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            bool isLastItem = (index + 1) % 2 == 2;

                            return GestureDetector(
                              onTap: () {
                                _showProductDetails(products[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors
                                          .textSecondarycolor, // Color of the border between rows
                                      width: isLastItem
                                          ? 0
                                          : 3, // Width of the border
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                          image:
                                              AssetImage(products[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                          width: 3.0,
                                          color: AppColors.bgprimaryColor,
                                        ),
                                      ),
                                      height: 90.0,
                                      width: 90.0,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      products[index].name,
                                      style: const TextStyle(
                                        fontFamily: 'roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle buy button click
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, '', (route) => false);
                                      },
                                      child: Text(
                                        'buy now',
                                        style: TextStyle(
                                            color: AppColors.textWhitecolor,
                                            fontSize: 10.0,
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
