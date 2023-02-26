import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {

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
                    Text('Crear Cuenta', style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(height: 10,),

                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                    
                  ],
                )
              ),
              SizedBox(height: 50,),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
                ),
                child: Text('¿Ya tienes una cuenta?', style: TextStyle(color: Colors.black87,fontSize: 15, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  //const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'matias@gmail.com', 
                labelText: 'Correo Electronico', 
                prefixIcon: Icons.alternate_email_outlined),
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'Valor ingresado incorrecto';
              },
              onChanged: (value) => loginForm.email = value,
            ),
            const SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*********', 
                labelText: 'Contraseña', 
                prefixIcon: Icons.lock_outline
              ),
              validator: (value) {
                if(value != null && value.length >= 6) return null;
                return 'La contraseña debe de ser de 6 caracteres';                
              },
              onChanged: (value) => loginForm.password = value,
            ),
            const SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading ? null : () async{

                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                if(!loginForm.isValidForm()) return;

                loginForm.isLoading = true;

                //await Future.delayed(Duration(seconds: 2));
                final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);

                if(errorMessage == null){
                  Navigator.pushNamed(context, 'home');
                } else {
                  print(errorMessage);
                }
                loginForm.isLoading = false;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere..' :
                  'Ingresar', 
                  style: TextStyle(color: Colors.white)
                )
              ),
            )
          ],
        )
      ),
    );
  }
}