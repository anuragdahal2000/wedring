import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_textfield.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/controllers/auth.dart';
import 'package:wedring/util/constant.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final bool _obsescurePasswordText = true;

  bool checkboxValue = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 56),
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: MediaQuery.of(context).size.height / 4,
              ),
              const Text(
                'Login to your Account ',
                style: kSemiBold20,
              ),
              const SizedBox(height: 8),
              const Text(
                "Welcome back, you've been missed",
                style: kRegular14,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 32,
                  left: 16,
                  right: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Email or phone',
                        controller: _emailController,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextField(
                        hintText: 'Password',
                        controller: _passwordController,
                        obscureText: _obsescurePasswordText,
                        forPassword: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Your Password';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.0,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    value: checkboxValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkboxValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Remember me',
                                style: kRegular14,
                              ),
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              context.goNamed('forgotpassword');
                            },
                            child: Text(
                              'Forgot password?',
                              style: kRegular14.copyWith(
                                color: kPrimaryColor1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: PrimaryButton(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  title: 'Login',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AuthService.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                      // context.goNamed('home');
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: kTeritary3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'or continue with',
                      style: kRegular14,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: kTeritary3,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextButton(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: kRegular14,
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: kMedium14.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    GoRouter.of(context).pushNamed('signup');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
