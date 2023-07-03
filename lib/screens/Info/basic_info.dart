import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_dropdown.dart';
import 'package:wedring/components/custom_textfield.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/utils/constant.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  List<String> states = [
    'Bagmati',
    'Gandaki',
    'Karnali',
    'Lumbini',
    'Province No. 1',
    'Province No. 2',
  ];
  List<String> cities = [
    'Kathmandu',
    'Lalitpur',
    'Bhaktapur',
    'Pokhara',
  ];
  List<String> maritalStatus = [
    'Never Married',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
    'Annulled',
  ];
  List<String> diet = [
    'Veg',
    'Non-Veg',
    'Eggetarian',
    'Vegan',
    'Jain',
    'Others',
  ];

  final spacing = const SizedBox(height: 16);

  bool isSwitched = false;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

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
            child: Column(
              children: [
                const Text(
                  'Thanks for signing up!. Now we need some basic info to get you started.',
                  style: kMedium18,
                ),
                spacing,
                CustomDropDown(
                  helperText: 'State',
                  optionList: states,
                  selectedOption: states[0],
                ),
                spacing,
                CustomDropDown(
                  helperText: 'City',
                  optionList: cities,
                  selectedOption: cities[0],
                ),
                spacing,
                CustomDropDown(
                  helperText: 'Marital Status',
                  optionList: maritalStatus,
                  selectedOption: maritalStatus[0],
                ),
                spacing,
                CustomDropDown(
                  helperText: 'Food Preference',
                  optionList: diet,
                  selectedOption: diet[0],
                ),
                spacing,
                CustomTextField(
                  helperText: 'Height (in cm)',
                  keyboardType: TextInputType.number,
                  hintText: 'Height',
                  controller: heightController,
                ),
                spacing,
                CustomTextField(
                  helperText: 'Weight (in kg)',
                  keyboardType: TextInputType.number,
                  hintText: 'Weight',
                  controller: weightController,
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
                    context.goNamed('edu-info');
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
