import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'contacts_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int home_index = 0;

  final screens = [
    const ContactsScreen(),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[home_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: home_index,
        onTap: (i) => setState(() => home_index = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: "Contact"),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: "Favorite"),
        ],
      ),
    );
  }
}
