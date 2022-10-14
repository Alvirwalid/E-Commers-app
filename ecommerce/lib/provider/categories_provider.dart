import 'package:ecommerce/model/categories_model.dart';
import 'package:ecommerce/service/custom_http.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  Future getcategoryData() async {
    categoryList = await CustomeHttp().fetchcategorydata();
    notifyListeners();
  }
}
