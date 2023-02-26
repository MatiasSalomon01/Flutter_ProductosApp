import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-productosapp-69ad6-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  

}