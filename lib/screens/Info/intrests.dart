import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/controllers/auth.dart';
import 'package:wedring/utils/constant.dart';

class IntrestModel {
  final String name;
  final IconData icon;
  IntrestModel({required this.name, required this.icon});
}

class IntrestScreen extends StatefulWidget {
  const IntrestScreen({super.key});

  @override
  State<IntrestScreen> createState() => _IntrestScreenState();
}

class _IntrestScreenState extends State<IntrestScreen> {
  final List<IntrestModel> _intrest = [
    IntrestModel(name: 'Photography', icon: Icons.camera_alt_outlined),
    IntrestModel(name: 'Music', icon: Icons.music_note_outlined),
    IntrestModel(name: 'Dance', icon: Icons.dynamic_feed),
    IntrestModel(name: 'Travel', icon: Icons.airplanemode_active),
    IntrestModel(name: 'Food', icon: Icons.fastfood_outlined),
    IntrestModel(name: 'Sports', icon: Icons.sports_basketball_outlined),
    IntrestModel(name: 'Fitness', icon: Icons.fitness_center_outlined),
    IntrestModel(name: 'Fashion', icon: Icons.shopping_bag_outlined),
    IntrestModel(name: 'Art', icon: Icons.palette_outlined),
    IntrestModel(name: 'Gaming', icon: Icons.sports_esports_outlined),
    IntrestModel(name: 'Reading', icon: Icons.menu_book_outlined),
    IntrestModel(name: 'Writing', icon: Icons.create_outlined),
    IntrestModel(name: 'Cooking', icon: Icons.restaurant_outlined),
    IntrestModel(name: 'Pets', icon: Icons.pets_outlined),
    IntrestModel(name: 'Movies', icon: Icons.movie_outlined),
    IntrestModel(name: 'Theatre', icon: Icons.theater_comedy_outlined),
    IntrestModel(name: 'Politics', icon: Icons.gavel_outlined),
    IntrestModel(name: 'Science', icon: Icons.science_outlined),
    IntrestModel(name: 'Technology', icon: Icons.computer_outlined),
    IntrestModel(name: 'History', icon: Icons.history_outlined),
    IntrestModel(name: 'Nature', icon: Icons.nature_outlined),
    IntrestModel(name: 'Cars', icon: Icons.car_rental_outlined),
    IntrestModel(name: 'Bikes', icon: Icons.two_wheeler_outlined),
    IntrestModel(name: 'Bussiness', icon: Icons.business_outlined),
    IntrestModel(name: 'Startups', icon: Icons.star_outline),
  ];
  final List<IntrestModel> _selectedIntrest = [];

  void handleInterestSelection(IntrestModel interest) {
    if (_selectedIntrest.contains(interest)) {
      _selectedIntrest.remove(interest);
    } else {
      _selectedIntrest.add(interest);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Intrests',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Intrests',
              style: kBold20,
            ),
            const Text(
              'Select a few of your intrests and let everyone know what you like',
              style: kRegular16,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: _intrest.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  IntrestModel intrest = _intrest[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        handleInterestSelection(intrest);
                      },
                      horizontalTitleGap: 0,
                      leading: Icon(intrest.icon),
                      title: Text(intrest.name),
                      selected: _selectedIntrest.contains(intrest),
                    ),
                  );
                },
              ),
            ),
            PrimaryButton(
              title: 'Continue',
              onPressed: () {
                context.read<AuthController>().setIntersets(
                      _selectedIntrest.map((e) => e.name).toList(),
                      FirebaseAuth.instance.currentUser!.uid,
                    );
                context.goNamed('home');
              },
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
