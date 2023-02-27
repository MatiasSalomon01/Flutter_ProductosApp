import 'package:flutter/material.dart';

class NotificationsService{
  static late GlobalKey<ScaffoldMessengerState> messegenderKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message, Color color){
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white, fontSize: 20),),
      backgroundColor: color,
    );

    messegenderKey.currentState!.showSnackBar(snackBar);
  }
}