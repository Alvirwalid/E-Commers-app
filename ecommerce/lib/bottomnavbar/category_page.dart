import 'package:ecommerce/const/text-style.dart';
import 'package:ecommerce/crud/add_category.dart';
import 'package:ecommerce/crud/edit_category.dart';
import 'package:ecommerce/provider/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ScrollController? _scrollController;
  bool buttonVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var categoryProvider =
        Provider.of<CategoryProvider>(context).getcategoryData();
    var categoryList = Provider.of<CategoryProvider>(context).categoryList;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: categoryList.isNotEmpty
            ? NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  setState(() {
                    if (notification.direction == ScrollDirection.forward) {
                      buttonVisible = true;
                    } else if (notification.direction ==
                        ScrollDirection.reverse) {
                      buttonVisible = false;
                    }
                  });

                  return true;
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 350,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        // width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    'https://apihomechef.antopolis.xyz/images/${categoryList[index].image}'))),
                                      ),
                                      Positioned(
                                        top: height * 0.18,
                                        left: width * 0.38,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              'https://apihomechef.antopolis.xyz/images/${categoryList[index].icon}'),
                                        ),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(100, 40),
                                              primary: Colors.pink),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (_) {
                                              return Editcategory(
                                                categoryModel:
                                                    categoryList[index],
                                              );
                                            }));
                                          },
                                          child: Text(
                                            'Edit',
                                            style: myStyle(fs: 18),
                                          )),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(100, 40),
                                              primary: Colors.pink),
                                          onPressed: () {},
                                          child: Text(
                                            'Delete',
                                            style: myStyle(fs: 18),
                                          )),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: ((context, index) => SizedBox(
                          height: 15,
                        )),
                    itemCount: categoryList.length),
              )
            : Center(
                child: CircularProgressIndicator(
                    //strokeWidth: 50,

                    )),
      ),
      floatingActionButton: buttonVisible
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return AddCategory();
                })).then((value) => ((value) {
                      Provider.of<CategoryProvider>(context).getcategoryData();
                    }));
              },
              child: Icon(
                Icons.add,
                color: Colors.pink,
              ),
            )
          : null,
    );
  }
}
