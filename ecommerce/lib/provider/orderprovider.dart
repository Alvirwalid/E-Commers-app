import 'package:ecommerce/model/oredermodel.dart';
import 'package:ecommerce/service/custom_http.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderList = [];
  getOrderData() async {
    orderList = await CustomeHttp().fetchOrderData();
    notifyListeners();
  }
}
