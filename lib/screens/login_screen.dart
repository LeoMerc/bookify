import 'package:bookify/const.dart';
import 'package:bookify/providers/libro_provider.dart';
import 'package:bookify/providers/login_form_providers.dart';
import 'package:bookify/widgets/auth_background.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';
import '../widgets/card_container.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200),
              CardContainer(
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  ),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: Text(
                  'Crear una nueva cuenta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final LibroProvider libroProvider =
        Provider.of<LibroProvider>(context, listen: false);
    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //TODO mantener la referencia al KEY
          child: Column(
            children: [
              TextFormField(
                onChanged: ((value) {
                  loginForm.email = value;
                }),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'JohnDoe@gmail.com',
                    labelText: 'Correo Electronico',
                    prefixIcon: Icons.alternate_email_sharp),
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El correo no es correcto';
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                onChanged: (value) {
                  loginForm.password = value;
                },
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'La contrasena debe de ser de 6 characteres';
                },
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*********',
                    labelText: 'Contrasena',
                    prefixIcon: Icons.lock_outline),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                disabledColor: Color.fromARGB(255, 136, 88, 218),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;

                        final res = await client.users
                            .authViaEmail(loginForm.email, loginForm.password);

                        libroProvider.isAdmin =
                            res.user!.profile!.data['admin'];
                        print(res.user!.profile!.data['admin']);
                        print(libroProvider.isAdmin);

                        if (res.token.isNotEmpty) {
                          await Navigator.pushReplacementNamed(context, 'home');
                        }
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: loginForm.isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text('Ingresar',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          )),
    );
  }
}
