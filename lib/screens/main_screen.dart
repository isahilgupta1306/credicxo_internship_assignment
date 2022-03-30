import 'package:credicxo_internship_assignment/screens/favorites_screen.dart';
import 'package:credicxo_internship_assignment/screens/home_screen.dart';
import 'package:credicxo_internship_assignment/utils/custom_colors.dart';
import 'package:flutter/material.dart';

import '../utils/check_internet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List _children = [const HomeScreen(), const FavoritesScreen()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    checkInternet().checkConnection(context);
    super.initState();
  }

  @override
  void dispose() {
    checkInternet().listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: cardColorbgColorDark,
        elevation: 0,
        selectedItemColor: primaryColorLight,
        unselectedItemColor: white.withOpacity(0.7),
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}
