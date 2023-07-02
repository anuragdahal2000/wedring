import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/utils/constant.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Info',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //User able to upload image or take a picture
                  const Spacer(),
                  const CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Add a profile image to complete your profile',
                    style: kBold20,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Your photos are completely safe with us',
                    style: kRegular12,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryButton(
                    title: 'Add From Gallery',
                    onPressed: () {},
                    icon: const Icon(
                      Icons.photo,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      variant: Variant.teritary,
                      title: 'Take a Picture',
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    variant: Variant.teritary,
                    title: 'Skip for now',
                    onPressed: () {
                      context.goNamed('interests');
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: 24,
            ),
            color: kTeritary2,
            width: double.infinity,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: kPrimaryColor1,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Photo Privacy controls are available in Settings. You can change them anytime. Learn more about',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
