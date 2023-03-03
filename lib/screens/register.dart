import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../components/textformfield.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repassword = TextEditingController();
  final dateinput = TextEditingController();
  String? myGender;
  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    repassword.dispose();
  }

  List<DropdownMenuItem<String>> gender = const [
    DropdownMenuItem(
      value: "male",
      child: Text("Male"),
    ),
    DropdownMenuItem(
      value: "female",
      child: Text("Female"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      width: 140, height: 60, fit: BoxFit.fill),
                ),
                SizedBox(
                  height: 25,
                ),
                const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Enter your name"),
                      MyFormField(
                        hint: "Your full name",
                        myController: name,
                        obsucure: false,
                        validator: (value) {
                          if (value!.isEmpty && !validator.name(value)) {
                            return "Enter valid name";
                          }
                          return null;
                        },
                        prefix: null,
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Enter your email"),
                      MyFormField(
                        hint: "Your email",
                        myController: email,
                        obsucure: false,
                        validator: (email) {
                          if ((email == null || email.isEmpty)) {
                            return "Can't be empty";
                          }
                          if (!validator.email(email))
                            return "Enter valid email";
                        },
                        prefix: Icon(Icons.email_outlined),
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Select your date of birth"),
                      MyFormField(
                          hint: "1999-02-14",
                          myController: dateinput,
                          obsucure: false,
                          suffix: IconButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2026),
                                );

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    dateinput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                              icon: Icon(Icons.date_range)),
                          prefix: null),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Enter your password"),
                      MyFormField(
                        hint: "Your password",
                        myController: password,
                        obsucure: true,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!validator.password(password)) {
                            return "Use 1 uppercase, 1 special chracter and 1 number";
                          }
                          return null;
                        },
                        prefix: Icon(Icons.key),
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Conform your password"),
                      MyFormField(
                        hint: "Re-enter your password",
                        myController: repassword,
                        obsucure: true,
                        validator: (enteredtext) {
                          if (enteredtext!.isEmpty) {
                            return "Cannot be empty";
                          }
                          if (enteredtext != password.text) {
                            return "Password donot match";
                          }
                        },
                        prefix: Icon(Icons.key),
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Select your gender"),
                      Container(
                        child: DropdownButtonFormField(
                          items: gender,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            hintText: "Select your gender",
                            prefixIcon: Icon(Icons.transgender),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                  color: Colors.purple, width: 1.5),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim() == '') {
                              return 'Gender is required';
                            }
                            return null;
                          },
                          onChanged: ((value) {
                            myGender = value;
                            print(myGender);
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.purple)),
                        onPressed: (() async {
                          if (_formkey.currentState!.validate()) {
                            print("Form Validated");
                          }
                        }),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "If you already have an account",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Row(children: [
                  const Text("You can"),
                  TextButton(
                      onPressed: (() {
                        setState(() {
                          Navigator.of(context)
                              .pop((MaterialPageRoute(builder: ((context) {
                            return const Login();
                          }))));
                        });
                      }),
                      child: const Text(
                        "Login here!",
                        style: TextStyle(color: Colors.purple),
                      ))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
