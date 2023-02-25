import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';


class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(child: Container(
        height: 100,
        width: double.infinity,
        color: Colors.red,
      ),)
   );
  }
}