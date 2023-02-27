import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';


class CheckAuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (context, snapshot) {
            if(snapshot.hasData)
              return Text('');

              if(snapshot.data == ''){
                Future.microtask(() {
                  //Navigator.of(context).pushReplacementNamed('login');
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                    transitionDuration: Duration(seconds: 0)
                  ));
                });
              }else{
                Future.microtask(() {
                  //Navigator.of(context).pushReplacementNamed('login');
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                    transitionDuration: Duration(seconds: 0)
                  ));
                });
              }
              return Container();
          },
        )
     ),
   );
  }
}