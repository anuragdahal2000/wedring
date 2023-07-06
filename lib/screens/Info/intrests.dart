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
  List<IntrestModel> _selectedIntrest = [];

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

class ListTileApp extends StatelessWidget {
  const ListTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const LisTileExample(),
    );
  }
}

class LisTileExample extends StatefulWidget {
  const LisTileExample({super.key});

  @override
  State<LisTileExample> createState() => _LisTileExampleState();
}

class _LisTileExampleState extends State<LisTileExample>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _sizeController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _sizeController = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _sizeAnimation = CurvedAnimation(
      parent: _sizeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile Samples')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Hero(
            tag: 'ListTile-Hero',
            // Wrap the ListTile in a Material widget so the ListTile has someplace
            // to draw the animated colors during the hero transition.
            child: Material(
              child: ListTile(
                title: const Text('ListTile with Hero'),
                subtitle: const Text('Tap here for Hero transition'),
                tileColor: Colors.cyan,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('ListTile Hero')),
                        body: Center(
                          child: Hero(
                            tag: 'ListTile-Hero',
                            child: Material(
                              child: ListTile(
                                title: const Text('ListTile with Hero'),
                                subtitle: const Text('Tap here to go back'),
                                tileColor: Colors.blue[700],
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            // Wrap the ListTile in a Material widget so the ListTile has someplace
            // to draw the animated colors during the fade transition.
            child: const Material(
              child: ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Center(
              child: SizeTransition(
                sizeFactor: _sizeAnimation,
                axisAlignment: -1.0,
                // Wrap the ListTile in a Material widget so the ListTile has someplace
                // to draw the animated colors during the size transition.
                child: const Material(
                  child: ListTile(
                    title: Text('ListTile with SizeTransition'),
                    tileColor: Colors.red,
                    minVerticalPadding: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
