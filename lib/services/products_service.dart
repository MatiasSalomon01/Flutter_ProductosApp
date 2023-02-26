import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-productosapp-69ad6-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService(){
    loadProducts();
  }

  //<List<Product>>
  Future<List<Product>> loadProducts() async{

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(res.body);

    productsMap.forEach((key, value) { 
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
    return products;
  }

  Future saveOrCreateProduct(Product product) async{
    isSaving = true;
    notifyListeners();

    if(product.id == null){
      await createProduct(product);
    }else{
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async{
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final res = await http.put(url, body: product.toRawJson());

    final decodedData = res.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async{
    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.post(url, body: product.toRawJson());

    final decodedData = json.decode(res.body);

    product.id = decodedData['name'];
    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path){
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage()async{
    if(newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dowuc5zob/image/upload?upload_preset=mus98oue');

    final imageUploadRequest = http.MultipartRequest('POST',url);
    
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final res = await http.Response.fromStream(streamResponse);

    // print(res.body);

    newPictureFile = null;

    final decodedData = json.decode(res.body);
    return decodedData['secure_url'];
  }
  
}