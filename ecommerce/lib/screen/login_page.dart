import 'package:ecommerce/bottomnavbar/bottom-vna_bar.dart';
import 'package:ecommerce/commonhelper/themehelper.dart';
import 'package:ecommerce/service/custom_http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailontroller = TextEditingController();
  TextEditingController passwordontroller = TextEditingController();

  Map<String, dynamic>? dataMap;

  var token;

  getLogin() async {
    dataMap = await CustomeHttp()
        .LoginUser(emailontroller.text, passwordontroller.text);

    if (dataMap!['access_token'] != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString('token', dataMap!['access_token']);
      sharedPreferences.setString('email', dataMap!['user']['email']);
      sharedPreferences.setString('name', dataMap!['user']['name']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return BottomNavPage();
      }));
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    token = sharedPreferences.getString('token');
    setState(() {});

    // print('your token isssssss${dataMap!['access_token']}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffFEDDC6),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('asset/image/bg.png'))),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 25),
                height: MediaQuery.of(context).size.height / 1.8,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF).withOpacity(.7),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextField(
                        // focusNode: focusNode,
                        controller: emailontroller,
                        decoration: ThemeHelper()
                            .textInputDecoration('Enter your email'),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextField(
                        // focusNode: focusNode,
                        controller: passwordontroller,
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'Password', 'Enter your password'),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          'Sign In'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        getLogin();
                      },
                    ),
                    //  Text('${data!["access_token"]}')
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
