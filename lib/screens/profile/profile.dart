import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/components/primary_button.dart';

import '../../utils/constant.dart';

class ProfileOption {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  ProfileOption({
    required this.title,
    this.icon = Icons.chevron_right,
    required this.onTap,
  });
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final List<ProfileOption> _moreSettings = [
      ProfileOption(
        onTap: () {},
        title: 'About Us',
      ),
    ];

    final List<ProfileOption> accountSettings = [
      ProfileOption(
        onTap: () {
          context.goNamed('profile-details');
        },
        title: 'My Profile',
      ),
      ProfileOption(
        onTap: () {},
        title: 'Change Password',
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currentUser.photoURL != null
                    ? CachedNetworkImage(
                        imageUrl: currentUser.photoURL!,
                        fit: BoxFit.contain,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: imageProvider,
                          radius: 48,
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo.png'),
                        radius: 48,
                        backgroundColor: Colors.white,
                      ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          currentUser.displayName ?? '',
                          style: kBold20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        currentUser.emailVerified
                            ? const Icon(
                                Icons.verified,
                                size: 16,
                                color: Colors.green,
                              )
                            : const SizedBox(),
                      ],
                    ),
                    Text(
                      currentUser.email!,
                      style: kRegular14,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Settings',
                    style: kRegular14.copyWith(color: kTeritary1),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: accountSettings.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          ProfileTile(
                            option: accountSettings[index],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      );
                    }),
                  ),
                  const Divider(),
                  Text(
                    'More',
                    style: kRegular14.copyWith(color: kTeritary1),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _moreSettings.length,
                    itemBuilder: ((context, index) {
                      return ProfileTile(
                        option: _moreSettings[index],
                      );
                    }),
                  ),
                  PrimaryButton(
                    variant: Variant.outline,
                    title: 'Logout',
                    icon: const Icon(Icons.logout),
                    horizontalIconSpace: 12,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      context.goNamed('signin');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final ProfileOption option;

  const ProfileTile({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      onTap: option.onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(
        option.title,
        style: kRegular14.copyWith(
          color: kPrimaryColor2,
        ),
      ),
      trailing: Icon(option.icon),
    );
  }
}
