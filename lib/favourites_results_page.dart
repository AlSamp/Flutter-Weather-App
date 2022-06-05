import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'package:weather_icons/weather_icons.dart';
import 'display_weather_icons.dart';
import 'package:sizer/sizer.dart';
import 'status_error_page.dart';

class FavouritesResultsPage extends StatefulWidget {
  late String mFavourites;

  FavouritesResultsPage(String apiCall) {
    mFavourites = apiCall;
  }

  @override
  State<FavouritesResultsPage> createState() => _FavouritesResultsPageState();
}

class _FavouritesResultsPageState extends State<FavouritesResultsPage> {
  late double mLongitude = 0;
  late double mLatitude = 0;
  late String mTargetLocation;
  String mLocation = "";
  String mTemperature = "";
  String mIcon = "";
  double mWindSpeed = 0.0;
  int mWindDirection = 0;
  int mHumidity = 0;

  void getTargetLocation() async {
    // check that the country is correct for json
    http.Response response = await http.get(
      Uri.parse(widget.mFavourites),
    );

    mTargetLocation = response.body;

    if (response.statusCode == 200) // 200 is http code for success
    {
      mLocation = jsonDecode(mTargetLocation)["data"]["city"]; // user
      mTemperature = jsonDecode(mTargetLocation)["data"]["current"]["weather"]
              ["tp"]
          .toString();
      mIcon = jsonDecode(mTargetLocation)["data"]["current"]["weather"]["ic"];
      mWindSpeed =
          jsonDecode(mTargetLocation)["data"]["current"]["weather"]["ws"];
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
  }

  @override
  void initState() {
    super.initState();
    getTargetLocation();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextButton(
              onPressed: () {
                setState(() {
                  getTargetLocation();
                  debugPrint("Favourite results Page Refresh Button Pressed");
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ],
              )),
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
                        mLocation),
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
