import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/functions/firebaseauthentication.dart';
import 'package:foodapp/models/category.model.dart';
import 'package:foodapp/services/stateMngt/cart.provider.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:foodapp/widgets/PopupMenu.dart';
import 'package:foodapp/widgets/SidebarmenuDrawer.dart';
import 'package:foodapp/widgets/Title.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final Categorys category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                // print("Tapped on ${category.name}");
                Navigator.pushNamed(context, '/welcomepage',
                    arguments: {'id': category.id, 'name': category?.name});
              },
              child: Container(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        category.image ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    Text(
                      category.name ?? '',
                      style: TextStyle(
                        color: AppColors.textPrimarycolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ).copyWith(
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (category.free == 'Yes')
              Positioned(
                top: 0,
                right: 0,
                child: Card(
                  color: AppColors.colorError,
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Free Drink',
                          style: TextStyle(
                            color: AppColors.textWhitecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MainpageCategoryScreen extends StatefulWidget {
  const MainpageCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MainpageCategoryScreen> createState() => _MainpageCategoryScreenState();
}

class _MainpageCategoryScreenState extends State<MainpageCategoryScreen> {
  Future<List<Categorys>>? futureCategory;
  final table = DatabaseService();

  final searchinput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  dynamic text;
  String searchText = '';
  List<Categorys> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    table.initialize().then((_) => fetchCategories());
  }

  void fetchCategories() async {
    setState(() {
      futureCategory = table.getCategories();
    });
  }

  settext() {
    setState(() {
      text = searchinput.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  --access app cart state
    var cartData = context.watch<CartProvider>().items;
    int totalQuantity = cartData;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              floating: true,
              pinned: true,
              centerTitle: false,
              title: myTitle(context, totalQuantity: totalQuantity),
              // -- handle add menu icon
              actions: [MyPopUpMenu(context)],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(
                    60.0), // You can adjust this value as needed
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 250.0,
                    height: 40.0,
                    child: Form(
                      child: TextFormField(
                        // controller: searchinput,
                        onChanged: (value) {
                          setState(() {
                            text = value;
                          });
                        },
                        autocorrect: true,
                        style: TextStyle(
                            color:
                                Colors.black), // This will make the text black
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors
                              .white, // This will make the background white
                          prefixIcon: Icon(Icons.search,
                              color: Colors
                                  .black), // This will add the search icon
                          hintText: "Search",
                          hintStyle: TextStyle(
                              color: Colors
                                  .black), // This will make the hint text black
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors
                                    .black), // This will make the border black
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .primaryColor), // This will make the border color change to primary color on focus
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: AppColors.textWhitecolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ).copyWith(
                      fontFamily: 'Roboto',
                    ),
                  ),
                  Text(
                    "  Homemade meals prepared with love.  ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColors.textWhitecolor,
                        ),
                  ),
                  Text(
                    "  Richest ingredients. ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColors.textWhitecolor,
                        ),
                  ),
                  Text(
                    "${text ?? ' '}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColors.textWhitecolor,
                        ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: FutureBuilder<List<Categorys>>(
                  future: Future.delayed(
                    Duration(
                        seconds:
                            2), // Change this to the number of seconds you want to delay
                    () => futureCategory ?? Future.value([]),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final data = snapshot.data;
                      if (data == null || data.isEmpty) {
                        return Column(
                          children: [
                            const Center(
                                child: Text('There are no categories')),
                            TextButton(
                                onPressed: () async {
                                  fetchCategories();
                                },
                                child: Text("Reload "))
                          ],
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          if (text != null && text != '') {
                            if (data[index]
                                .name
                                .toLowerCase()
                                .contains(text.toLowerCase())) {
                              return CategoryCard(category: data[index]);
                            }
                            return Container();
                          }
                          return CategoryCard(category: data[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        drawer: MySideBarMenu(context));
  }
}
