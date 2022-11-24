import 'package:bookify/providers/login_form_providers.dart';
import 'package:bookify/widgets/auth_background.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../const.dart';
import '../providers/register_form_providers .dart';
import '../ui/input_decorations.dart';
import '../widgets/card_container.dart';

class RegisterScreen extends StatelessWidget {
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
                    'Register',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => RegisterFormProvider(),
                    child: _RegisterForm(),
                  ),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Ya tengo una cuenta',
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

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
          key: registerForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //TODO mantener la referencia al KEY
          child: Column(
            children: [
              TextFormField(
                onChanged: ((value) {
                  registerForm.email = value;
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
                  registerForm.password = value;
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
              TextFormField(
                onChanged: (value) {
                  registerForm.confirmPassword = value;
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
                    labelText: 'Confirmar contrasena',
                    prefixIcon: Icons.lock_outline),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                disabledColor: Color.fromARGB(255, 136, 88, 218),
                onPressed: registerForm.isLoading
                    ? null
                    : () async {
                        if (registerForm.password ==
                            registerForm.confirmPassword) {
                          FocusScope.of(context).unfocus();
                          if (!registerForm.isValidForm()) return;

                          final user = await client.users.create(body: {
                            'email': registerForm.email,
                            'password': registerForm.password,
                            'passwordConfirm': registerForm.confirmPassword,
                          });
                          if (user.id.isNotEmpty) {
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            print('no se creo');
                          }
                        } else {
                          print('a');
                        }
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: registerForm.isLoading
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
