import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/screens/onboarding/onboard_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedring/util/constant.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int? currentPage = 0;

  List<Map<String, String>> onboardData = [
    {
      "title": "Algorithm",
      "subtitle":
          " Users going through a vetting process to ensure that they are real and not bots.",
      "image": "assets/images/onboard/1.jpg",
    },
    {
      "title": "Matches",
      "subtitle":
          "We match you with people who share your interests and values.",
      "image": "assets/images/onboard/2.jpg",
    },
    {
      "title": "Chat",
      "subtitle": "You can chat with your matches and get to know them better.",
      "image": "assets/images/onboard/3.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var pageView = PageView.builder(
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemCount: onboardData.length,
      itemBuilder: (context, index) {
        return OnboardContent(
          image: onboardData[index]['image']!,
          title: onboardData[index]['title']!,
          subtitle: onboardData[index]['subtitle']!,
        );
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: pageView,
            ),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: onOnboardingComplete,
                        child: Text(
                          'SKIP',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: TextButton(
                            onPressed: (currentPage == onboardData.length - 1)
                                ? onOnboardingComplete
                                : () {
                                    pageView.controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onOnboardingComplete() async {
    SharedPreferences inst = await SharedPreferences.getInstance();
    await inst.setBool("onboarded", true).then(
          (value) => context.goNamed('signin'),
        );
    //TODO: Navigate to home screen
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor1 : kPrimaryColor2,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
