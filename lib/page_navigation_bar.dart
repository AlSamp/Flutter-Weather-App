import 'package:flutter/material.dart';
import 'package:mobile_computing_assignment/favourites_page.dart';
import 'weather_page.dart';
import 'search_page.dart';
import 'favourites_page.dart';
import 'settings_page.dart';

class ScreenNavigation extends StatefulWidget {
  const ScreenNavigation({Key? key}) : super(key: key);

  @override
  State<ScreenNavigation> createState() => _ScreenNavigationState();
}

class _ScreenNavigationState extends State<ScreenNavigation> {
  final screens = [
    const WeatherPage(),
    const SearchPage(),
    FavouritesPage(),
    const SettingsPage(),
  ];

  int navBarIndex = 0; // start with on weather page
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: IndexedStack(
            // This keeps the pages how they were lost used instead of destroying and creating new ones
            index: navBarIndex,
            children: screens,
          ),
          // Display screens in the body of the screen
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting, // Animation for navbar
            selectedItemColor: Colors.white,
            //iconSize: 40,
            unselectedItemColor: Colors.grey,
            onTap: (index) => setState(() => navBarIndex =
                index), // when user clicks on navbar element record the selected index
            currentIndex:
                navBarIndex, // update navbar with user selected option
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.my_location),
                label: "Weather",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "Favourites",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
                backgroundColor: Colors.black,
              )
            ],
          )),
    );
  }
}


// Tutorial used for navigation bar https://www.youtube.com/watch?v=xoKqQjSDZ60