import 'package:flutter/material.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/util/constant.dart';

class EmptyScreenTemplate extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final PrimaryButton primaryButton;
  final PrimaryButton? secondaryActionButton;

  const EmptyScreenTemplate({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.primaryButton,
    this.secondaryActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Column(
        children: [
          Image.asset(imagePath),
          const SizedBox(
            height: 32.0,
          ),
          Text(
            title,
            style: kMedium18.copyWith(
              color: kPrimaryColor2,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              subtitle,
              style: kRegular14.copyWith(
                color: kTeritary1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: primaryButton,
          ),
          secondaryActionButton != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: secondaryActionButton!,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
