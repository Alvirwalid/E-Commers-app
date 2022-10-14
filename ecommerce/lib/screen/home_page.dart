import 'package:ecommerce/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
            child: ElevatedButton(
                onPressed: (() async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('token');

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return LoginPage();
                  }));
                }),
                child: Text('Logout'))),
      ),
    );
  }
}
