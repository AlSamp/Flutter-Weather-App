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
  late String _favourites;
  late String _city;
  late String _id;

  FavouritesResultsPage(String apiCall, String city, String id) {
    _favourites = apiCall;
    _city = city;
    _id = id;
  }

  @override
  State<FavouritesResultsPage> createState() => _FavouritesResultsPageState();
}

class _FavouritesResultsPageState extends State<FavouritesResultsPage> {
  late double mLongitude = 0;
  late double mLatitude = 0;
  late String mTargetLocation;
  late String mCity = widget._city;
  late String mId = widget._id;
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
        Uri.parse(widget._favourites),
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
            "404",
          ),
        ),
      );
    }
  }

  void removeFavourite(String target) {
    debugPrint("Remove favourites called");
    fireStore.collection('favourites').doc(mId).delete();
  }

  bool checkFavoured(String target) {
    // if found in list make sure star icon is coloured
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
    // add data to firebase
    if (favoured == false) {
      fireStore.collection("favourites").add({
        "location": mCity,
        "apiCall":
            "http://api.airvisual.com/v2/city?city=$mCity&state=$mState&country=$mCountry&key=$kApiKey"
      });

      debugPrint("$mCity added to favourites");
    } else if (favoured == true) {
      //remove data from firebase
      removeFavourite(mId);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      checkFavoured(mCity);
      getTargetLocation();
    });
    debugPrint(mId);
  }

  Widget build(BuildContext context) {
    setState(() {
      //getTargetLocation();
    });
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
                  debugPrint("Favourites result page refresh button pressed");
                },
                child: Icon(
                  Icons.refresh,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  /// Display appropriate background image
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
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 30,
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
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      (DisplayerWeatherIcon(mIcon).displayStatus()).toString(),
                    ),
                    Text(
                        // Display Temperatire
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 100,
                        ),
                        "$mTemperature°"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            BoxedIcon(
                              // Display windspeed icon
                              WeatherIcons.strong_wind,
                              size: 8.5.h,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            Text(
                              // Display windspeed
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
                          // Display windspeed direction
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
                          // Display humidity
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
