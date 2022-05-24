import 'package:flutter/material.dart';
import 'navigation_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("This is the search Page")),
        body: Container(
          color: Colors.blue,
          child: Center(
            child: Text("Search Page"),
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(),
      ),
    );
  }
}
