import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_textfield.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/controllers/auth.dart';
import 'package:wedring/utils/constant.dart';

import '../../utils/helper.dart';

class EmailPasswordReset extends StatefulWidget {
  const EmailPasswordReset({super.key});

  @override
  State<EmailPasswordReset> createState() => _EmailPasswordResetState();
}

class _EmailPasswordResetState extends State<EmailPasswordReset> {
  bool checkboxValue = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  late FirebaseAuthException? _authException;
  final AuthController _authController = AuthController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Reset Link'),
      ),
      persistentFooterButtons: [
        SizedBox(
          height: 50,
          child: PrimaryButton(
            padding: const EdgeInsets.symmetric(vertical: 8),
            title: 'Send Reset Link',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _authException =
                    await _authController.resetPassword(_emailController.text);
                setState(() {});
                if (_authException == null) {
                  showSnackBar('Reset Link Sent');
                  if (!mounted) return;
                  context.goNamed('signin');
                }
              }
            },
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the email address associated with your account',
                style: kBold16,
              ),
              const SizedBox(
                height: 8,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                      ),
                      validator: (value) {
                        bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value!);

                        if (value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        if (!emailValid) {
                          return 'Please Enter Valid Email';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
