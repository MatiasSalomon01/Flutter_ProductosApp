import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/theme/theme.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsService(),)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'home',
      routes: {
        'home':(context) => HomeScreen(),
        'login':(context) => LoginScreen(),
        'product':(context) => ProductScreen(),
      },
      theme: ThemeApp.theme
    );
  }
}