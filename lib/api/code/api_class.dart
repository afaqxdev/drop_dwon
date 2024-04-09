import 'dart:convert';

import 'package:drop_down/api/product_model.dart';
import 'package:http/http.dart' as https;

class ApiClass {
  List<ProductModel> prodectlist = [];
  Future<void> getList() async {
    final Uri uri = Uri.parse("https://fakestoreapi.com/products");
    final response = await https.get(uri);
    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body.toString());
      for (var i in jsonDecode) {
        prodectlist.add(ProductModel.fromJson(i));
      }
    }
  }
}
