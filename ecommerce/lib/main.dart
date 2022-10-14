import 'package:ecommerce/provider/categories_provider.dart';
import 'package:ecommerce/provider/orderprovider.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/provider/profileprovider.dart';
import 'package:ecommerce/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => OrderProvider())),
        ChangeNotifierProvider(create: ((context) => CategoryProvider())),
        ChangeNotifierProvider(create: ((context) => ProductProvider())),
        ChangeNotifierProvider(create: (context) => ProfileProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: SplashScreen(),
      ),
    );
  }
}
