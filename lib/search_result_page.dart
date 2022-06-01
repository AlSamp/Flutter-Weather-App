import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';

class SearchCitiesPage extends StatefulWidget {
  late String mSelectedCountry;
  late String mSelectedState;
  late String mSelectedCity;

  SearchCitiesPage(String country, String state, String city) {
    mSelectedCountry = country;
    mSelectedState = state;
    mSelectedCity = city;
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
  late String mCity = widget.mSelectedCity;
  void countryCheck() {
    if (mCountry == "United Kingdom") {
      mCountry = "UK";
    }
  }

  void getCountries() async {
    countryCheck(); // check that the country is correct for json
    http.Response response = await http.get(
      Uri.parse(
          "http://api.airvisual.com/v2/city?city=$mCity&state=$mState&country=$mCountry&key=$kApiKey"),
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
      //body: Text("$"),
    );
  }
}

// TODO : This page acquires geolocation of city. It then needs to geolocate and gather that citys info ready for display.
