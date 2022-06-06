import 'package:flutter/material.dart';
import 'favourites_results_page.dart';
import 'globals.dart';
import 'package:sizer/sizer.dart';
import 'status_error_page.dart';

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
                      builder: (context) {
                        try {
                          return FavouritesResultsPage(
                              favouritesApiCall[index], favouritesList[index]);
                        } catch (error) {
                          return StatusErrorPage(
                            "Favourites Page Error",
                            "Selected item has been removed, Refresh page",
                          );
                        }
                      },
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
