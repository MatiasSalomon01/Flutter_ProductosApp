import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-productosapp-69ad6-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  bool isLoading = true;

  ProductsService(){
    loadProducts();
  }

  //<List<Product>>
  Future loadProducts() async{
    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(res.body);

    productsMap.forEach((key, value) { 
      final tempProduct = Product.fromJson(value);

      tempProduct.id = key;

      products.add(tempProduct);
    });
    print(products[0].name);
  }
}