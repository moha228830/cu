import 'dart:async';
import 'dart:convert';

import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:provider/provider.dart';

Future<List<Product>> fetchProducts(http.Client client, id, type) async {
  final response = await client
      .get(Config.url + 'items?type=' + type + '&sub_id=' + id.toString());

  // Use the compute function to run parseProducts in a separate isolate.
  return parseProducts(response.body);
}

// A function that converts a response body into a List<Product>.
List<Product> parseProducts(responseBody) {
  final parsed =
      jsonDecode(responseBody)["data"]["items"].cast<Map<String, dynamic>>();
  //print(jsonDecode(responseBody)["msg"]);

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class PostDataProvider with ChangeNotifier {
  String m = "fefefe";
  List<Product> post = [];
  bool loading = false;

  getPostData(http.Client client, id, type) async {
    loading = true;
    post = await fetchProducts(client, id, type);

    loading = false;
    return post;

    notifyListeners();
  }

  second() {
    return post;
    notifyListeners();
  }
}
