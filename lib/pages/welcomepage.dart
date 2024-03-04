import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/models/products.model.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';

void main() {
  runApp(WelcomePage());
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePagesState();
}

class _WelcomePagesState extends State<WelcomePage> {
  final List<Product> products = [
    Product(
      id: 1,
      name: 'Pizza',
      image: 'assets/images/pizza.jpeg',
      description: 'Tasty pizza with cheese and tomato sauce',
      price: 10.99,
      category: 1,
      sellerId: 1,
    ),
    Product(
      id: 2,
      name: 'chicken',
      image: 'assets/images/chicken.jpeg',
      description: 'Tasty chicken with cheese and tomato sauce',
      price: 10.99,
      category: 2,
      sellerId: 2,
    ),
    Product(
      id: 3,
      name: 'chicken wrap',
      image: 'assets/images/chickenwrap.jpeg',
      description: 'Tasty chicken wrap with cheese and tomato sauce',
      price: 10.99,
      category: 3,
      sellerId: 3,
    ),
    Product(
      id: 4,
      name: 'Sushi',
      image: 'assets/images/pilaurice.jpeg',
      description: 'Tasty sushi with cheese and tomato sauce',
      price: 10.99,
      category: 4,
      sellerId: 4,
    ),
    Product(
        id: 5,
        name: 'spanish rice',
        description: 'Tasty spanish rice with cheese and tomato sauce',
        price: 10.99,
        image: 'assets/images/spanishrice.jpeg',
        sellerId: 5,
        category: 5),
  ];

<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _currentIndex = (_pageController.page ?? 0).round();
    });
  }

  Widget _buildCategoryList({required List<Product> products}) {
    return SizedBox(
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        controller: _pageController,
        itemCount: products.length,
        reverse: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppColors.bgSecondary,
                    title: Text(products[index].name),
                    content: Column(
                      children: <Widget>[
                        Image.asset(products[index].image),
                        Text('Name: ${products[index].name}'),
                        Text('Price: ${products[index].price}'),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    products[index].image,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Name: ${products[index].name},',
                    style: TextStyle(
                      color: AppColors.textPrimarycolor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Price: ${products[index].price},',
                    style: TextStyle(
                      color: AppColors.textPrimarycolor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: ${products[index].price}',
                    style: TextStyle(
                      color: AppColors.textWhitecolor,
                      fontSize: 16,
                    ),
                  ),
                ],
=======
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
>>>>>>> b761b37 (updating)
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
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _buildCategoryGrid = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of items per row
        crossAxisSpacing: 0, // spacing between items horizontally
        mainAxisSpacing: 0, // spacing between items vertically
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _showProductDetails(products[index]);
          },
          child: Container(
            margin: const EdgeInsets.only(),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage(products[index].image),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      width: 3.0,
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
                const SizedBox(height: 5.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle buy button click
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/mainpagecategory', (route) => false);
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
    );
    return Scaffold(
      backgroundColor: AppColors.bgprimaryColor,
      body: SafeArea(
<<<<<<< HEAD
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
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
                        Navigator.pushNamed(context, '/login');
                      },
=======
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: AppColors.textWhitecolor,
                      size: 30,
>>>>>>> b761b37 (updating)
                    ),
                    onPressed: () {
                      print(' tapped');
                      //if you tapped on menu icon it will take you to the login page
                      Navigator.pushNamed(context, '/login');
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
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      color: AppColors.textWhitecolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '   Homemade meals prepared with',
                    style: TextStyle(
                      color: AppColors.textWhitecolor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '      love.Richest ingredients.',
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
<<<<<<< HEAD
                ),
                child: _buildCategoryList(
                  products: [
                    Product(
                        id: 1,
                        name: 'Pizza',
                        image: 'assets/images/pizza.jpeg',
                        description: 'Tasty pizza with cheese and tomato sauce',
                        price: 10.99,
                        sellerId: 1,
                        category: 3),
                    Product(
                        id: 2,
                        name: 'chicken',
                        image: 'assets/images/chicken.jpeg',
                        description:
                            'Tasty chicken with cheese and tomato sauce',
                        price: 10.99,
                        sellerId: 2,
                        category: 4),
                    Product(
                        id: 3,
                        name: 'chicken wrap',
                        image: 'assets/images/chickenwrap.jpeg',
                        description:
                            'Tasty chicken wrap with cheese and tomato sauce',
                        price: 10.99,
                        sellerId: 3,
                        category: 5),
                    Product(
                        id: 4,
                        name: 'Sushi',
                        image: 'assets/images/pilaurice.jpeg',
                        description: 'Tasty sushi with cheese and tomato sauce',
                        price: 10.99,
                        sellerId: 4,
                        category: 6),
                    Product(
                        id: 5,
                        name: 'spanish rice',
                        description:
                            'Tasty spanish rice with cheese and tomato sauce',
                        price: 10.99,
                        image: 'assets/images/spanishrice.jpeg',
                        sellerId: 5,
                        category: 6)
                  ],
=======
                  child: _buildCategoryGrid,
>>>>>>> b761b37 (updating)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
