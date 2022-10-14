import 'package:ecommerce/model/productmodel.dart';
import 'package:ecommerce/service/custom_http.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> productList = [];

  Future getProductData() async {
    productList = await CustomeHttp().fetchProductData();
    notifyListeners();
  }
}
