import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/custom_dropdown.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/controllers/auth.dart';
import 'package:wedring/utils/constant.dart';
import 'package:provider/provider.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  bool checkboxValue = false;

  final _formKey = GlobalKey<FormState>();

  final List<String> _gotra = [
    'Agasti (अगस्ती)',
    "Atri (अत्रि)",
    "Aatreya (आत्रेय) ",
    "Bharadwaaj (भरद्वाज)",
    "Dhananjaya (धनञ्जय)",
    "Garg (गर्ग)",
    "Gautam (गौतम)",
    "Ghrita Kaushik (घृत कौशिक)",
    "Kapil (कपिल)",
    "Kashyap (कश्यप)",
    "Kaudinya (कौण्डिन्य)",
    "Kausalya (कौसल्य)",
    "Kausik (कौशिक)",
    "Kundin (कुण्डिन)",
    "Mandabya (माण्डव्य)",
    "Maudagalya (मौद्गल्य)",
    "Parasar (परासर)",
    "Ravi (रवि)",
    "Sankhyayan (सङ्ख्यायन)",
    "Shandilya (शाण्डिल्य)",
    "Upamanyu (उपमन्यु)",
    "Vishwamitra (विश्वमित्र)",
    "Vatsa (वत्स)",
    "Vashishta (वशिष्ठ)",
  ];

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
  List<String> gender = ['Male', 'Female', 'Others'];

  late String selectedGender = gender[0];
  late String selectedReligion = religionList[0];
  late String selectedCommunity = communityList[0];
  late String selectedState = states[0];
  late String selectedCity = cities[0];
  late String selectedGotra = _gotra[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'More about you',
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropDown(
                        helperText: 'Gender',
                        optionList: gender,
                        selectedOption: selectedGender,
                        onChanged: (p0) {
                          setState(() {
                            selectedGender = p0!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomDropDown(
                        helperText: 'State',
                        optionList: states,
                        selectedOption: selectedState,
                        onChanged: (p0) => setState(() {
                          selectedState = p0!;
                        }),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomDropDown(
                        helperText: 'City',
                        optionList: cities,
                        selectedOption: selectedCity,
                        onChanged: (p0) => setState(() {
                          selectedCity = p0!;
                        }),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomDropDown(
                        helperText: 'Religion',
                        optionList: religionList,
                        selectedOption: selectedReligion,
                        onChanged: (p0) {
                          setState(() {
                            selectedReligion = p0!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomDropDown(
                        helperText: 'Community',
                        optionList: communityList,
                        selectedOption: selectedCommunity,
                        onChanged: (p0) {
                          setState(() {
                            selectedCommunity = p0!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomDropDown(
                        helperText: 'Gotra',
                        optionList: _gotra,
                        selectedOption: selectedGotra,
                        onChanged: (p0) {
                          setState(() {
                            selectedGotra = p0!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  title: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<AuthController>()
                          .setRegistrationPage2Details(
                            selectedGender,
                            selectedReligion,
                            selectedCommunity,
                            selectedState,
                            selectedCity,
                            selectedGotra,
                            FirebaseAuth.instance.currentUser!.uid,
                          );
                      context.goNamed('basic-info');
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
}
