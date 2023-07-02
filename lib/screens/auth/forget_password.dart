import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/utils/constant.dart';

class PasswordResetMethodModel {
  final String title;
  final String subtitle;
  final IconData icon;

  PasswordResetMethodModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  int _selectedMethodIndex = 0;
  final List<PasswordResetMethodModel> _passwordResetMethods = [
    PasswordResetMethodModel(
      icon: Icons.mobile_friendly_outlined,
      title: "Reset Via SMS",
      subtitle: "+977 98*********11",
    ),
    PasswordResetMethodModel(
      icon: Icons.email_outlined,
      title: "Reset Via Email",
      subtitle: "abc***@gmail.com",
    ),
  ];
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
                "Please Choose a Method",
                style: kSemiBold20,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Select which contact would you like to send the reset code.',
                style: kRegular14,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _passwordResetMethods.length,
                itemBuilder: (BuildContext context, int index) {
                  PasswordResetMethodModel method =
                      _passwordResetMethods[index];
                  return PasswordResetMethodCard(
                    icon: method.icon,
                    title: method.title,
                    subtitle: method.subtitle,
                    isSelected: _selectedMethodIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedMethodIndex = index;
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                title: 'Proceed',
                onPressed: () {
                  context.goNamed('opt-verfication');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordResetMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final Function() onTap;

  const PasswordResetMethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 3000),
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          color: kTeritary2,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  width: 1,
                  color: kPrimaryColor1,
                  style: BorderStyle.solid,
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: kPrimaryColor2,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kMedium14.copyWith(
                    color: kPrimaryColor2,
                  ),
                ),
                Text(
                  subtitle,
                  style: isSelected
                      ? kMedium14.copyWith(
                          color: kPrimaryColor2,
                        )
                      : kRegular14,
                ),
              ],
            ),
            const Spacer(),
            isSelected
                ? Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: kPrimaryColor1,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 20,
                      color: kBackgroundColor2,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
