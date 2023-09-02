import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/custom_textfield.dart';
import '../../components/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final bool _obsescurePasswordText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        PrimaryButton(
          title: 'Change Password',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _auth.currentUser!.updatePassword(_newPasswordController.text);
              Navigator.pop(context);
            }
          },
        ),
      ],
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Password',
              helperText: 'Old Password',
              controller: _oldPasswordController,
              obscureText: _obsescurePasswordText,
              forPassword: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Your Password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              helperText: 'New Password',
              hintText: 'New Password',
              controller: _newPasswordController,
              obscureText: _obsescurePasswordText,
              forPassword: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Your Password';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
