import 'package:flutter/material.dart';
import 'package:wedring/util/constant.dart';

class OnboardContent extends StatelessWidget {
  final String image, title, subtitle;

  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(image),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: kBold20,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: kMedium16,
          )
        ],
      ),
    );
  }
}
