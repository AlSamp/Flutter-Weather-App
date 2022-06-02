import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'search_result_page.dart';

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

  void getCountries() async {
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

    setState(() {}); // this update the screen with the list of countries
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Cities in $mState"),
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
