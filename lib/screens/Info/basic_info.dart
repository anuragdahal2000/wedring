import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_dropdown.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/util/constant.dart';

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
  List<String> height = [
    '4ft 0in',
    '4ft 1in',
    '4ft 2in',
    '4ft 3in',
    '4ft 4in',
    '4ft 5in',
    '4ft 6in',
    '5ft 9in',
    '5ft 10in',
    '5ft 11in',
    '6ft 0in',
    '6ft 1in',
    '6ft 2in',
    '6ft 3in',
  ];

  final spacing = const SizedBox(height: 16);

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Basic Info',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Form(
          child: Column(
            children: [
              const Text(
                'Thanks for signing up!. Now we need some basic info to get you started.',
                style: kMedium18,
              ),
              spacing,
              CustomDropDown(optionList: states, selectedOption: states[0]),
              spacing,
              CustomDropDown(optionList: cities, selectedOption: cities[0]),
              spacing,
              CustomDropDown(
                optionList: maritalStatus,
                selectedOption: maritalStatus[0],
              ),
              spacing,
              CustomDropDown(
                optionList: diet,
                selectedOption: diet[0],
              ),
              spacing,
              CustomDropDown(
                optionList: height,
                selectedOption: height[0],
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
    );
  }
}
