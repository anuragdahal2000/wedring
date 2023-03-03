import 'package:flutter/material.dart';

import '../components/textformfield.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checkValue = false;

  final _formkey = GlobalKey<FormState>();
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  bool myObsucure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/w.png",
                    width: 150, height: 70, fit: BoxFit.fill),
              ),
              SizedBox(
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email'),
                        MyFormField(
                          hint: "Your Email Here",
                          myController: loginEmail,
                          obsucure: false,
                          prefix: Icon(Icons.email_outlined),
                          suffix: null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Password"),
                        MyFormField(
                          hint: "Your Password",
                          myController: loginPassword,
                          obsucure: myObsucure,
                          prefix: Icon(Icons.key),
                          suffix: IconButton(
                            icon: Icon(myObsucure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                myObsucure = !myObsucure;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: checkValue,
                        onChanged: ((value) {
                          setState(() {
                            checkValue = value!;
                          });
                        }),
                      ),
                      TextButton(
                        onPressed: (() {}),
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.purple,
                          ),
                        ),
                        onPressed: (() async {
                          if (_formkey.currentState!.validate()) {
                            // ignore: unused_local_variable
                            Map toSend = {
                              "email": loginEmail.text,
                              "password": loginPassword.text,
                            };
                          }
                        }),
                        child: const Text("Login")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "If you don`t have an account",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("You can"),
                      TextButton(
                          onPressed: (() {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return const RegisterPage();
                            })));
                          }),
                          child: const Text(
                            'Register here!',
                            style: TextStyle(color: Colors.purple),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
