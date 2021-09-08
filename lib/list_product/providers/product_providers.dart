import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:test_twistcode/list_product/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _data = [];
  bool isSuccess = false;
  bool isLoading = false;
  List<Product> get data => _data;

  getProducts() async {
    Uri url = Uri.parse(
        'https://ranting.twisdev.com/index.php/rest/items/search/api_key/teampsisthebest/');
    isLoading = true;
    var result = await http.post(url);
    isLoading = false;

    var jsonResult = jsonDecode(result.body);

    if (result.statusCode == 200) {
      isSuccess = true;
      if (jsonResult != null) {
        jsonResult
            .map((element) => {_data.add(Product.fromjson(element))})
            .toList();
      }
    } else {
      isSuccess = false;
    }
    notifyListeners();
  }
}
