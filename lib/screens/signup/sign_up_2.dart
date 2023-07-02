import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_dropdown.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/utils/constant.dart';
import 'package:wedring/utils/helper.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  bool checkboxValue = false;

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _username = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "More about you",
                  style: kSemiBold20,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Please fill the form below to complete your registration",
                  style: kRegular14,
                ),
                const SizedBox(
                  height: 12,
                ),
                buildFormWidget(),
                PrimaryButton(
                  title: 'Submit',
                  onPressed: () {
                    if (checkboxValue) {
                      context.goNamed('basic-info');
                      // if (_formKey.currentState!.validate()) {
                      //   AuthService.register(
                      //     _email.text,
                      //     _phoneController.text,
                      //     _passwordController.text,
                      //     _username.text,
                      //   );
                      // }
                    } else {
                      showSnackBar(
                        'Please accept the terms and conditions to proceed',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form buildFormWidget() {
    List<String> religionList = [
      'Hindu',
      'Muslim',
      'Christian',
      'Sikh',
      'Buddhist',
      'Jain',
      'Other'
    ];
    List<String> communityList = [
      'Brahmin',
      'Kshatriya',
      'Vaishya',
      'Shudra',
      'Other'
    ];
    List<String> livingIn = [
      'Nepal',
      'India',
      'UK',
      'Canada',
      'Australia',
      'New Zealand',
      'Other'
    ];
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Religon',
            style: kRegular16,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomDropDown(
            optionList: religionList,
            selectedOption: religionList[0],
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Community',
            style: kRegular16,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomDropDown(
            optionList: communityList,
            selectedOption: communityList[0],
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Living in',
            style: kRegular16,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomDropDown(
            optionList: livingIn,
            selectedOption: livingIn[0],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.0,
                child: Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    value: checkboxValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkboxValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'I agree to given Terms and Conditions ',
                style: kRegular14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
