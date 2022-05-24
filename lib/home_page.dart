import 'package:flutter/material.dart';
import 'globals.dart';
import 'navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: Favourites',
      style: optionStyle,
    ),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     //_selectedIndex = index;
  //     gCurrentPage = index;
  //     debugPrint("Index $index was pressed"); // Verifying tabbar button presses

  //     //Navigator.push(
  //     //    context, MaterialPageRoute(builder: ((context) => FavouritesPage())));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(gCurrentPage),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
