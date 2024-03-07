import 'package:flutter/material.dart';
import 'package:foodapp/models/category.model.dart';
import 'package:foodapp/utils/colors.dart';

Widget myCategoryCard(BuildContext context, Future<List<Categorys>> future,
    {text, click, isloading}) {
  print("cattttttttt${future}");
  return FutureBuilder<List<Categorys>>(
      future: future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: AppColors.backgroundWhite,
          ));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return Text('There is No Products');
          }
          return ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                //           onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ProductPage(category: data[index]),
                //     ),
                //   );
                // }

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Stack(
                      children: [
                        Container(
                          // height: 200,
                          // decoration: BoxDecoration(
                          // borderRadius:
                          // ),

                          child: Column(
                            children: [
                              Image.asset(
                                data[index].image ?? '',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              Text(data[index].name),
                            ],
                          ),
                        ),
                        if (data[index].free == 'Yes')
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Card(
                              color: Colors.green,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Free Drink'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      });
}
