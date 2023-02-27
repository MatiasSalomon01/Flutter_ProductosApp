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
        ChangeNotifierProvider(create: (context) => AuthService(),),
        ChangeNotifierProvider(create: (context) => ProductsService(),),
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
      initialRoute: 'checking',
      routes: {
        'login':(context) => LoginScreen(),
        'register':(context) => RegisterScreen(),

        'home':(context) => HomeScreen(),
        'product':(context) => ProductScreen(),

        'checking':(context) => CheckAuthScreen(),
      },
      theme: ThemeApp.theme
    );
  }
}