import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'product',
      routes: {
        'home':(context) => HomeScreen(),
        'login':(context) => LoginScreen(),
        'product':(context) => ProductScreen(),
      },
      theme: ThemeApp.theme
    );
  }
}