import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'package:weather_icons/weather_icons.dart';
import 'display_weather_icons.dart';
import 'package:sizer/sizer.dart';
import 'status_error_page.dart';
import 'package:favorite_button/favorite_button.dart';

class FavouritesResultsPage extends StatefulWidget {
  late String mFavourites;
  late String mCity;

  FavouritesResultsPage(String apiCall, String city) {
    mFavourites = apiCall;
    mCity = city;
  }

  @override
  State<FavouritesResultsPage> createState() => _FavouritesResultsPageState();
}

class _FavouritesResultsPageState extends State<FavouritesResultsPage> {
  late double mLongitude = 0;
  late double mLatitude = 0;
  late String mTargetLocation;
  late String mCity = widget.mCity;
  String mCountry = "";
  String mState = "";
  String mTemperature = "";
  String mIcon = "";
  double mWindSpeed = 0.0;
  int mWindDirection = 0;
  int mHumidity = 0;
  bool favoured = true;

  void getTargetLocation() async {
    try {
      // check that the country is correct for json
      http.Response response = await http.get(
        Uri.parse(widget.mFavourites),
      );

      mTargetLocation = response.body;

      if (response.statusCode == 200) // 200 is http code for success
      {
        mCountry = jsonDecode(mTargetLocation)["data"]["country"];
        mState = jsonDecode(mTargetLocation)["data"]["state"];
        mCity = jsonDecode(mTargetLocation)["data"]["city"];
        mTemperature = jsonDecode(mTargetLocation)["data"]["current"]["weather"]
                ["tp"]
            .toString();
        mIcon = jsonDecode(mTargetLocation)["data"]["current"]["weather"]["ic"];
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
              "Favourite Results Page",
              response.statusCode.toString(),
            ),
          ),
        );
      }

      // this update the screen with the list of countries
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

  void removeFavourite(String target) {
    for (int i = 0; i < favouritesList.length; i++) {
      if (target == favouritesList[i]) {
        favouritesList.removeAt(i);
        favouritesApiCall.removeAt(i);
        debugPrint("$mCity removed from favourites at index $i");
      }
    }
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
    if (checkFavourites(mCity) == false) {
      favouritesList.add(mCity);
      favouritesApiCall.add(
          "http://api.airvisual.com/v2/city?city=$mCity&state=$mState&country=$mCountry&key=$kApiKey");
      debugPrint("$mCity added to favourites");
    } else if (checkFavourites(mCity) == true) {
      removeFavourite(mCity);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      //favoured;
      getTargetLocation();
    });
  }

  Widget build(BuildContext context) {
    setState(() {
      //getTargetLocation();
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                  debugPrint("Favourites result page refresh button pressed");
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.black,
          centerTitle: true,

          //leading: Icon(Icons.star),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage("lib/images/background (5).jpg"),
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
                  color: Color.fromARGB(
                    185,
                    158,
                    158,
                    158,
                  ),
                  borderRadius: BorderRadius.circular(
                    3.0.h,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                        mCity),
                    SizedBox(
                      height: 1,
                      width: 50.h,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    BoxedIcon(
                      //Display Weather Icon

                      (DisplayerWeatherIcon(mIcon).displayIcon()),
                      color: Colors.black,
                      size: 25.h,
                    ),
                    Text(
                      // Display weather status
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      (DisplayerWeatherIcon(mIcon).displayStatus()).toString(),
                    ),
                    Text(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 100,
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
                              color: Colors.black,
                            ),
                            Text(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              "$mWindSpeed/mph",
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                              ),
                              "Windspeed",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            WindIcon(
                              color: Colors.black,
                              degree: mWindDirection,
                              size: 10.6.h,
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                              ),
                              "Wind Direction",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            BoxedIcon(
                              WeatherIcons.humidity,
                              color: Colors.black,
                              size: 6.75.h,
                            ),
                            Text(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.sp,
                                ),
                                mHumidity.toString()),
                            Text(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
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
