import 'package:flutter/material.dart';
import 'package:productos_app/theme/theme.dart';
import 'package:productos_app/widgets/widgets.dart';


class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),

              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(height: 10,),
                    _LoginForm()
                  ],
                )
              ),
              SizedBox(height: 50,),
              Text('Crear una nueva cuenta', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2
                  )
                ),
                hintText: 'matisalomond@gmail.com',
                labelText: 'Correo',
                labelStyle: TextStyle(
                  color: Colors.deepPurple
                ),
                prefixIcon: Icon(Icons.alternate_email_outlined, color: Colors.deepPurple,)
              ),
            )
          ],
        )
      ),
    );
  }
}