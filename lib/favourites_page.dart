import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'favourites_results_page.dart';
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:sizer/sizer.dart';

class FavouritesPage extends StatefulWidget {
  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  // ListViewPage({Key key}) : super(key: key);

  void initState() {
    super.initState();
    debugPrint("Favourites Page Loaded");
    //getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Your Favourites",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      body: ListView.builder(
        itemCount: favouritesApiCall.length, // length of list
        itemBuilder: (BuildContext, index) {
          return TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavouritesResultsPage(favouritesApiCall[index]),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(favouritesList[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
