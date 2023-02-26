import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBq3mXkFymRl2M7896TerQQVSeUVPP99-g';

  final storage = FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email' : email,
      'password' : password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp',{
      'key': _firebaseToken
    });

    final res = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedRes = json.decode(res.body);

    //print(decodedRes);

    if(decodedRes.containsKey('idToken')){
      //Guardar token en un lugar seguro
      await storage.write(key: 'token', value: decodedRes['idToken']);
      // return decodedRes['idToken'];
      return null;
    }else{
      return decodedRes['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email' : email,
      'password' : password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword',{
      'key': _firebaseToken
    });

    final res = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedRes = json.decode(res.body);

    //print(decodedRes);

    if(decodedRes.containsKey('idToken')){
      //Guardar token en un lugar seguro
      await storage.write(key: 'token', value: decodedRes['idToken']);
      // return decodedRes['idToken'];
      return null;
    }else{
      return decodedRes['error']['message'];
    }
  }

  Future logout() async{
    await storage.delete(key: 'token');
    return;
  }

}