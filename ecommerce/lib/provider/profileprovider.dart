import 'package:ecommerce/service/custom_http.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  Map<String, dynamic>? profileData;

  Future fetchProfileData() async {
    profileData = await CustomeHttp().getprofileData();
    notifyListeners();
  }
}
