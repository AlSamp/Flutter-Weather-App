import 'package:cloud_firestore/cloud_firestore.dart';
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
  // how firebase will show favourites. Boolean as it will be toggled
  bool ascendingOrder = true;

  void initState() {
    super.initState();
    debugPrint("Favourites Page Loaded");
    //getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: TextButton(
            onPressed: () {
              setState(() {
                // change view of user favourites
                ascendingOrder = !ascendingOrder;
                debugPrint("Favourites page button pressed");
              });
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
                    children: const [
                      Icon(
                        Icons.sort_by_alpha_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      // Display data from firebase
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore
            .collection("favourites")
            .orderBy("location", descending: ascendingOrder)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data;
            List docWidgets = [];
            for (var doc in documents!.docs) {
              final docWidget = doc;
              docWidgets.add(docWidget);
              //debugPrint(messageWidget.data);
            }
            // Display data from firebase as interactable cards
            return ListView.builder(
              itemCount: docWidgets.length, // length of list
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
                        // on tap create page of the users selected favourite
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              try {
                                return FavouritesResultsPage(
                                    docWidgets[index]
                                        .get("apiCall")
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', ''),
                                    docWidgets[index]
                                        .get("location")
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', ''),
                                    docWidgets[index].id);
                              } catch (error) {
                                debugPrint(docWidgets[index]
                                    .keys
                                    .toString()
                                    .replaceAll('(', '')
                                    .replaceAll(')', ''));
                                return StatusErrorPage(
                                  "Favourites Page",
                                  "Invalid Option",
                                );
                              }
                            },
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          docWidgets[index]
                              .get("location")
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', ''),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            // load error just in case but this should never be reached
            return StatusErrorPage(
              "Favourites Page",
              "Loading Error",
            );
          }
        },
      ),
    );
  }
}
