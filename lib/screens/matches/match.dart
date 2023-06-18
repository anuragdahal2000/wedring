import 'package:flutter/material.dart';
import 'package:wedring/util/constant.dart';

class MyMatches extends StatelessWidget {
  MyMatches({super.key});

  final matches = [
    {
      'name': 'John Doe',
      'image': 'assets/images/onboard/1.jpg',
      'age': '25',
      'location': 'Lagos, Nigeria',
      'occupation': 'Software Engineer',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Matches',
            style: kBold20,
          ),
          const Text(
            'This is a list of people you have liked you and your matches',
            style: kMedium16,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: matches.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, idx) => Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        matches[idx]['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            matches[idx]['name']!,
                            style: kSemiBold16,
                          ),
                          Text(
                            matches[idx]['age']!,
                            style: kMedium14,
                          ),
                          Text(
                            matches[idx]['location']!,
                            style: kMedium14,
                          ),
                          Text(
                            matches[idx]['occupation']!,
                            style: kMedium14,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
