import 'package:flutter/material.dart';
//import 'home_page.dart';

class FavouritesPage extends StatelessWidget {
  //const ListViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Infinite List"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              leading: Text("$index"), title: Text("Number $index"));
        },
      ),
    );
  }
}
