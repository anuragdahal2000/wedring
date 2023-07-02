import 'package:flutter/material.dart';
import 'package:wedring/components/custom_textfield.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/utils/constant.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Your New Password",
                style: kSemiBold20,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Please enter a 8-digit password.',
                style: kRegular14,
              ),
              const SizedBox(
                height: 16,
              ),
              buildFormWidget(),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                title: 'Change Password',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form buildFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              if (value.length < 8) {
                return 'Please enter atleast 8 digits';
              }
              return null;
              // return errorIn(lastResponse, "password");
            },
            controller: _passwordController,
            hintText: 'Password',
            forPassword: true,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            controller: _confirmPasswordController,
            //validataion
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please re-enter password';
              }
              if (value.length < 8) {
                return 'Please enter atleast 8 digits';
              }
              if (_passwordController.text != _confirmPasswordController.text) {
                return 'Password doesnot match';
              }
              return null;
              // return errorIn(lastResponse, "confirm_password");
            },

            hintText: 'Confirm Password',
            forPassword: true,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
