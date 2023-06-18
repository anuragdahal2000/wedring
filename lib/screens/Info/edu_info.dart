import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/util/constant.dart';

import '../../components/custom_dropdown.dart';
import '../../components/primary_button.dart';

class EduInfo extends StatefulWidget {
  const EduInfo({super.key});

  @override
  State<EduInfo> createState() => _EduInfoState();
}

class _EduInfoState extends State<EduInfo> {
  final spacing = const SizedBox(height: 16);

  final List<String> qualification = [
    'Bachelors',
    'Masters',
    'Doctorate',
    'Diploma',
    'Undergraduate',
    'Associates degree',
    'Honours degree',
    'Trade school',
    'High school',
    'Less than high school',
    'PhD',
    'Postdoctoral',
  ];

  final List<String> workWith = [
    'Private Company',
    'Government / Public Sector',
    'Defense / Civil Services',
    'Business / Self Employed',
    'Not Working',
    'Student',
    'Retired',
    'Non Working',
  ];

  final List<String> workAs = [
    'Admin Professional',
    'Clerk',
    'Operator/Technician',
    'Secretary/Front Office',
    'Actor',
    'Advertising Professional',
    'Entertainment Professional',
    'Event Management Professional',
    'Journalist',
    'Media Professional',
    'Public Relations Professional',
    'Farmar',
    'Agriculture & Farming Professional',
    'Air Hostess / Flight Attendant',
  ];

  final List<String> annualIncome = [
    'No Income',
    'Less than Rs. 1 Lakh',
    'Rs. 0 - 1 Lakh',
    'Rs. 1 - 2 Lakh',
    'Rs. 2 - 3 Lakh',
    'Rs. 3 - 4 Lakh',
    'Rs. 4 - 5 Lakh',
    'Rs. 5 - 7.5 Lakh',
    'Rs. 7.5 - 10 Lakh',
    'More than Rs. 10 Lakh',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Education & Career',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              const Text(
                'Just few more steps! Please add education and career details.',
                style: kMedium18,
              ),
              spacing,
              CustomDropDown(
                  optionList: qualification, selectedOption: qualification[0]),
              spacing,
              CustomDropDown(optionList: workWith, selectedOption: workWith[0]),
              spacing,
              CustomDropDown(optionList: workAs, selectedOption: workAs[0]),
              spacing,
              CustomDropDown(
                optionList: annualIncome,
                selectedOption: annualIncome[0],
              ),
              spacing,
              PrimaryButton(
                title: 'Continue',
                onPressed: () {
                  context.goNamed('profile-info');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}