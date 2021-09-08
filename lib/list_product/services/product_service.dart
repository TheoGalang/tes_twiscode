import 'dart:convert';

import 'package:test_twistcode/list_product/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_twistcode/list_product/views/list_product.dart';

class ProductService {
  bool isSuccess = false;
  bool isLoading = false;

  Future<List<Product>> getProducts() async {
    List<Product> _data = [];
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
    return _data;
  }
}
