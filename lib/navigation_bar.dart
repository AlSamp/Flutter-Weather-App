import 'package:flutter/material.dart';
import 'globals.dart';
import 'favourites_page.dart';
import 'home_page.dart';
import 'search_page.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  void _onItemTapped(int index) {
    setState(() {
      //_selectedIndex = index;
      gCurrentPage = index;
      debugPrint("Index $index was pressed"); // Verifying tabbar button presses

      if (gCurrentPage == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => HomePage())));
      } else if (gCurrentPage == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => SearchPage())));
      } else if (gCurrentPage == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => FavouritesPage())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourtites',
          ),
        ],
        currentIndex: gCurrentPage,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
