import 'package:ecommerce/const/text-style.dart';
import 'package:ecommerce/provider/profileprovider.dart';
import 'package:ecommerce/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var token = sharedPreferences.remove('token');

    setState(() {});

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.fetchProfileData();

    var data = profileProvider.profileData;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Container(
                width: 300,
                height: 300,
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      backgroundImage: AssetImage('./asset/image/person.png'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${data!['name']}',
                      style: myStyle(fw: FontWeight.bold, fs: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${data!['email']}',
                      style: myStyle(fw: FontWeight.bold, fs: 20),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await signOut();
                        },
                        child: Text('Log Out'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
