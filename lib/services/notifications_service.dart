import 'package:flutter/material.dart';

class NotificationsService{
  static late GlobalKey<ScaffoldMessengerState> messegenderKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white, fontSize: 20),),
      backgroundColor: Colors.red,
    );

    messegenderKey.currentState!.showSnackBar(snackBar);
  }
}