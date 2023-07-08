import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/controllers/auth.dart';
import 'package:wedring/utils/constant.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
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
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey,
                    child: image == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 40,
                          )
                        : Image.file(File(image!.path)),
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
                    onPressed: () async {
                      image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      setState(() {});
                    },
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
                      onPressed: () async {
                        image = await picker.pickImage(
                          source: ImageSource.camera,
                        );
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  ),
                  const Spacer(),
                  image != null
                      ? PrimaryButton(
                          variant: Variant.outline,
                          title: 'Proceed',
                          onPressed: () {
                            context
                                .read<AuthController>()
                                .uploadProfileImage(image!.path);
                            context.goNamed('interests');
                          },
                        )
                      : const SizedBox.shrink(),
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
