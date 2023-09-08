import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_dropdown.dart';
import 'package:wedring/components/custom_textfield.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/controllers/auth.dart';
import 'package:wedring/models/user.dart';
import 'package:wedring/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:wedring/utils/helper.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  List<String> maritalStatus =
      MaritalStatus.values.map((e) => e.toString().split('.')[1]).toList();
  List<String> foodPreference =
      FoodPreference.values.map((e) => e.toString().split('.')[1]).toList();

  final spacing = const SizedBox(height: 16);

  bool isSwitched = false;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? selectedMaritalStatus;
  String? seletedFoodPreference;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Basic Info',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Thanks for signing up!. Now we need some basic info to get you started.',
                  style: kMedium18,
                ),
                spacing,
                CustomDropDown(
                  helperText: 'Marital Status',
                  optionList: maritalStatus,
                  selectedOption: selectedMaritalStatus,
                  onChanged: (p0) => setState(() {
                    selectedMaritalStatus = p0!;
                  }),
                ),
                spacing,
                CustomDropDown(
                  helperText: 'Food Preference',
                  optionList: foodPreference,
                  selectedOption: seletedFoodPreference,
                  onChanged: (p0) => setState(() {
                    seletedFoodPreference = p0!;
                  }),
                ),
                spacing,
                CustomTextField(
                  helperText: 'Height (in cm)',
                  keyboardType: TextInputType.number,
                  hintText: 'Height',
                  controller: heightController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your height';
                    }
                    if (int.tryParse(p0) == null) {
                      return 'Please enter a valid height';
                    }
                    return null;
                  },
                ),
                spacing,
                CustomTextField(
                  helperText: 'Weight (in kg)',
                  keyboardType: TextInputType.number,
                  hintText: 'Weight',
                  controller: weightController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your weight';
                    }
                    if (int.tryParse(p0) == null) {
                      return 'Please enter a valid weight';
                    }
                    return null;
                  },
                ),
                spacing,
                Row(
                  children: [
                    Checkbox(
                      value: isSwitched,
                      onChanged: (val) {
                        setState(() {
                          isSwitched = val!;
                        });
                      },
                    ),
                    const Text(
                      'Not particular about my partner\'s community',
                      style: kRegular12,
                    ),
                  ],
                ),
                PrimaryButton(
                  title: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedMaritalStatus != null &&
                        seletedFoodPreference != null) {
                      MaritalStatus maritalStatus = MaritalStatus.values
                          .firstWhere((e) =>
                              e.toString().split('.').last ==
                              selectedMaritalStatus);
                      FoodPreference foodPreference = FoodPreference.values
                          .firstWhere((e) =>
                              e.toString().split('.').last ==
                              seletedFoodPreference);
                      context
                          .read<AuthController>()
                          .setRegistrationPage3Details(
                            maritalStatus,
                            foodPreference,
                            heightController.text,
                            weightController.text,
                            FirebaseAuth.instance.currentUser!.uid,
                          );
                      context.goNamed('edu-info');
                    } else {
                      showSnackBar('Please fill all the fields',
                          type: SnackType.error);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
