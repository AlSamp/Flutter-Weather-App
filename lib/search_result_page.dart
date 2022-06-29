import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin

import 'dart:convert'; //json conversion
import 'globals.dart';
import 'package:weather_icons/weather_icons.dart';
import 'display_weather_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:favorite_button/favorite_button.dart';
import 'status_error_page.dart';

class SearchResultsPage extends StatefulWidget {
  late String mSelectedCountry;
  late String mSelectedState;
  late String mSelectedCity;

  SearchResultsPage(String country, String state, String city) {
    mSelectedCountry = country;
    mSelectedState = state;
    mSelectedCity = city;
  }

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  //_SearchStatesPageState(String selectedCountry) {
  //  mSelectedCountry = selectedCountry;
  //}

  late String mCountry = widget.mSelectedCountry;
  late String mState = widget.mSelectedState;
  late String mCity = widget.mSelectedCity;
  late double mLongitude = 0;
  late double mLatitude = 0;
  late String mTargetLocation;
  String mLocation = "";
  String mTemperature = "";
  String mIcon = "";
  double mWindSpeed = 0.0;
  int mWindDirection = 0;
  int mHumidity = 0;
  bool favoured = false;
  bool gotList = false;
  void getTargetLocation() async {
    if (gotList == false) {
      try {
        // check that the country is correct for json
        http.Response response = await http.get(
          Uri.parse(
              "http://api.airvisual.com/v2/city?city=$mCity&state=$mState&country=$mCountry&key=$kApiKey"),
        );
        debugPrint(
            "http://api.airvisual.com/v2/city?city=$mCity&state=$mState&country=$mCountry&key=$kApiKey");
        debugPrint("Search results page json result" + response.body);

        mTargetLocation = response.body;

        if (response.statusCode == 200) // 200 is http code for success
        {
          mLocation =
              jsonDecode(mTargetLocation)["data"]["city"]; // user location
          mTemperature = jsonDecode(mTargetLocation)["data"]["current"]
                  ["weather"]["tp"]
              .toString();
          mIcon =
              jsonDecode(mTargetLocation)["data"]["current"]["weather"]["ic"];
          mWindSpeed = jsonDecode(mTargetLocation)["data"]["current"]["weather"]
                  ["ws"]
              .toDouble();
          mWindDirection =
              jsonDecode(mTargetLocation)["data"]["current"]["weather"]["wd"];
          mHumidity =
              jsonDecode(mTargetLocation)["data"]["current"]["weather"]["hu"];
        } else {
          debugPrint(response.statusCode.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatusErrorPage(
                "Search Reult",
                response.statusCode.toString(),
              ),
            ),
          );
        }
        gotList = true;
        setState(() {}); // this update the screen with the list of countries
      } catch (error) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatusErrorPage(
              "Search States Page",
              "404 : Internet connection not found",
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint("Search results page Loaded");
    favoured = checkFavoured(mCity);
    setState(() {});
    getTargetLocation();
  }

  bool checkFavoured(String target) {
    debugPrint("Check favoured called");
    if (favouritesList.isNotEmpty) {
      for (int i = 0; i < favouritesList.length; i++) {
        if (target == favouritesList[i]) {
          debugPrint("$target found in favourites");
          debugPrint("Check favoured returned true");
          return true;
        } else {
          debugPrint("$target not found in favourites");
          debugPrint("Check favoured returned false");
          return false;
        }
      }
    }
    debugPrint("Check favoured returned null s false it is");
    return false;
  }

  void addFavourite() {
    debugPrint(mCity);
    if (checkFavourites(mCity) == false) {
      favouritesList.add(mCity);
      debugPrint("$mCity added to favourites");
      //favouritesApiCall.add(
      //    "http://api.airvisual.com/v2/city?city=$mCity&state=$mState&country=$mCountry&key=$kApiKey");

      fireStore.collection("favourites").add({
        "location": mCity,
        "apiCall":
            "http://api.airvisual.com/v2/city?city=$mCity&state=$mState&country=$mCountry&key=$kApiKey"
      });
    } else if (checkFavourites(mCity) == true) {
      //removeFavourite(mCity);
    }
  }

//TODO : Sizer measurements
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StarButton(
                  isStarred: favoured,
                  valueChanged: (_) {
                    addFavourite();
                    favoured = !favoured; // become opposite
                    debugPrint("Star button pressed isStarred == $favoured");
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    getTargetLocation();
                  });
                  debugPrint("Search result page refresh button pressed");
                },
                child: Icon(
                  Icons.refresh,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),

          //leading: Icon(Icons.star),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  isDarkMode ? gDarkBackgroundImage : gLightBackgroundImage,
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(
                  1.5.h,
                ),
                padding: EdgeInsets.all(1.5.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(
                    3.0.h,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                        // Display selected city name
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 28.sp,
                        ),
                        mCity),
                    SizedBox(
                      height: 1,
                      width: 50.h,
                      child: Container(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    BoxedIcon(
                      //Display Weather Icon

                      (DisplayerWeatherIcon(mIcon).displayIcon()),
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 25.h,
                    ),
                    Text(
                      // Display weather status
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      (DisplayerWeatherIcon(mIcon).displayStatus()).toString(),
                    ),
                    Text(
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 80.sp,
                        ),
                        "$mTemperature°"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            BoxedIcon(
                              WeatherIcons.strong_wind,
                              size: 8.5.h,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            Text(
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: 15.sp,
                              ),
                              "$mWindSpeed/mph",
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                              "Windspeed",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            WindIcon(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              degree: mWindDirection,
                              size: 10.6.h,
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                              "Wind Direction",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            BoxedIcon(
                              WeatherIcons.humidity,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              size: 6.75.h,
                            ),
                            Text(
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 30.sp,
                                ),
                                mHumidity.toString()),
                            Text(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                              "Humidity",
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// TODO : This page acquires geolocation of city. It then needs to geolocate and gather that citys info ready for display.
