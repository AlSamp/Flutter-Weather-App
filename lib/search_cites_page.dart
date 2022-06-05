import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'search_result_page.dart';
import 'package:sizer/sizer.dart';

class SearchCitiesPage extends StatefulWidget {
  late String mSelectedCountry;
  late String mSelectedState;

  SearchCitiesPage(String country, String state) {
    mSelectedCountry = country;
    mSelectedState = state;
  }

  @override
  State<SearchCitiesPage> createState() => _SearchCitiesPageState();
}

class _SearchCitiesPageState extends State<SearchCitiesPage> {
  //_SearchStatesPageState(String selectedCountry) {
  //  mSelectedCountry = selectedCountry;
  //}
  List<String> apiCities = []; // empty list
  late int numCities = 0;
  late String mCountry = widget.mSelectedCountry;
  late String mState = widget.mSelectedState;
  void countryCheck() {
    if (mCountry == "United Kingdom") {
      mCountry = "UK";
    }
  }

  void getCities() async {
    countryCheck(); // check that the country is correct for json
    http.Response response = await http.get(
      Uri.parse(
          "http://api.airvisual.com/v2/cities?state=$mState&country=$mCountry&key=$kApiKey"),
    );

    if (response.statusCode == 200) // 200 is http code for success
    {
      final cities = response.body;

      for (int i = 0; i < 200; i++) {
        try {
          apiCities.add(jsonDecode(cities)["data"][i]["city"]);
          numCities++;
        } catch (error) {
          // There will be a read access violation so break the for loop
          break;
        }
      }
    } else {
      debugPrint(response.statusCode.toString());
    }

    setState(() {
      SearchCitiesPage;
    }); // this update the screen with the list of countries
  }

  @override
  void initState() {
    super.initState();
    getCities();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextButton(
          onPressed: () {
            setState(() {
              getCities();
              debugPrint("State Page Refresh Button Pressed");
            });
          },
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  //maxLines: 1,
                  //softWrap: false,
                  "Cities in $mState",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: numCities,
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
                          SearchResultsPage(mCountry, mState, apiCities[index]),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(apiCities[index]),
                  trailing: Text("..."),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
