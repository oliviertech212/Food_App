import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/models/products.model.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController _pageController;
  int _currentIndex = 0;

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
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgprimaryColor,
      body: SafeArea(
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
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.bgprimaryColor,
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
                                    color: AppColors.bgprimaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      color: AppColors.textWhitecolor,
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
                      width: 150,
                      child: TextFormField(
                          decoration: InputDecoration(
                        hintText: 'Search Menu',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: AppColors.textPrimarycolor,
                          fontSize: 15,
                        ),
                      )),
                    )
                  ],
                ),
              ),
              Container(
                height: 900.0,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: AppColors.bgSecondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
