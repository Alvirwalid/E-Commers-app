import 'dart:convert';

import 'package:ecommerce/model/categories_model.dart';
import 'package:ecommerce/model/oredermodel.dart';
import 'package:ecommerce/model/productmodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomeHttp {
  Future<Map<String, dynamic>> LoginUser(String email, String password) async {
    var link = 'https://apihomechef.antopolis.xyz/api/admin/sign-in';
    const Map<String, String> defaultheader = {'Accept': 'application/json'};

    Map<String, dynamic> map = {'email': email, 'password': password};

    Map<String, dynamic>? dataMap;
    try {
      var respons =
          await http.post(Uri.parse(link), body: map, headers: defaultheader);

      var data = jsonDecode(respons.body);

      dataMap = Map<String, dynamic>.from(data);

      if (respons.statusCode == 200) {
        return dataMap;
      } else {
        return Map();
      }
    } catch (e) {
      print('error is $e');
    }
    return dataMap!;
  }

  Future<Map<String, String>> getheaderWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> map = {
      'Accept': 'application/json',
      'Authorization': 'bearer ${sharedPreferences.getString('token')}'
    };

    //  print('object ${sharedPreferences.getString('token')}');
    return map;
  }

  Future<List<OrderModel>> fetchOrderData() async {
    var link = 'https://apihomechef.antopolis.xyz/api/admin/all/orders';

    List<OrderModel> orederList = [];

    try {
      var respons =
          await http.get(Uri.parse(link), headers: await getheaderWithToken());

      //print('respons iss ${respons.body}');
      var data = jsonDecode(respons.body);

      // print(' data is $data');
      OrderModel orderModel;

      for (var i in data) {
        orderModel = OrderModel.fromJson(i);
        orederList.add(orderModel);
      }

      print('orderList is ${orederList[0].orderDateAndTime}');
      return orederList;
    } catch (e) {
      print('The problem is $e');
    }
    return orederList;
  }

  Future<List<CategoryModel>> fetchcategorydata() async {
    List<CategoryModel> categoryList = [];
    var link = 'https://apihomechef.antopolis.xyz/api/admin/category';

    try {
      var respons =
          await http.get(Uri.parse(link), headers: await getheaderWithToken());

      // print('category data isss ${respons.body}');

      var data = jsonDecode(respons.body);

      CategoryModel categoryModel;
      for (var i in data) {
        categoryModel = CategoryModel.fromJson(i);

        categoryList.add(categoryModel);
      }
      // print('category list isss ${categoryList[0].name}');

      return categoryList;
    } catch (e) {
      print('Problem is $e');
    }

    return categoryList;
  }

  Future<List<ProductModel>> fetchProductData() async {
    List<ProductModel> productData = [];
    try {
      var link = 'https://apihomechef.antopolis.xyz/api/admin/products';

      var respons = await http.get(Uri.parse(link), headers: <String, String>{
        'Accept': 'application/json',
        'Authorization':
            'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY2NTAwMDgyMSwiZXhwIjoxNjc3OTYwODIxLCJuYmYiOjE2NjUwMDA4MjEsImp0aSI6IjRGRXFKdWhvNk5CN254OUEiLCJzdWIiOjc1LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.PL4js56r7cbf_AmYAxRaQ3EMKlj7GZSskayDNT8GotA'
      });

      //print('respons issssssss ${respons.body}');

      ProductModel productModel;

      var data = jsonDecode(respons.body);

      for (var i in data) {
        productModel = ProductModel.fromJson(i);

        productData.add(productModel);
      }
      //print(productData.length);

      print(productData[0].image);

      return productData;
    } catch (e) {
      print(e.toString());
    }
    return productData;
  }

  Future<Map<String, dynamic>> getprofileData() async {
    var uri = Uri.parse('https://apihomechef.antopolis.xyz/api/admin/profile');

    Map<String, dynamic> dataMap;

    Map<String, String> map = {
      'Accept': 'application/json',
      'Authorization':
          'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY2NTc0ODc3OCwiZXhwIjoxNjc4NzA4Nzc4LCJuYmYiOjE2NjU3NDg3NzgsImp0aSI6IkNLUkYyZkU0cndVU2NGVDYiLCJzdWIiOjc1LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.aQprSpRbRGVu_sy1TXAjFNZ57tpaScRKriwGDHHX1-Y'
    };

    var response = await http.get(uri, headers: map);

    //print(response.body);

    var data = jsonDecode(response.body);

    dataMap = Map<String, dynamic>.from(data);

    print('datamap isssssssssssss $dataMap');

    print(dataMap['name']);

    return dataMap;
  }
}
