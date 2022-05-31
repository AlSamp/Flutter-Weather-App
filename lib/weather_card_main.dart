import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'display_weather_icons.dart';
import 'package:sizer/sizer.dart';

class MainWeatherCard extends StatefulWidget {
  @override
  State<MainWeatherCard> createState() => _MainWeatherCardState();

  late String mLocation;
  late String mTemperature;
  late String mIcon;
  late double mWindSpeed;
  late int mWindDirection;
  late int mHumidity;

// Constructor
  MainWeatherCard(
    String location,
    String temperature,
    String icon,
    double windSpeed,
    int windDirection,
    int humidity,
  ) {
    mLocation = location;
    mTemperature = temperature;
    mIcon = icon;
    mWindSpeed = windSpeed;
    mWindDirection = windDirection;
    mHumidity = humidity;
  }
}

class _MainWeatherCardState extends State<MainWeatherCard> {
  @override
  void setDeafultCardVariables() {
    if (widget.mLocation == "") {
      widget.mLocation = "Tap To Refresh";
    }
  }

  Widget build(BuildContext context) {
    setDeafultCardVariables();
    return Column(
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
                  "${widget.mLocation}"),
              SizedBox(
                height: 1,
                width: 50.h,
                child: Container(
                  color: Colors.white,
                ),
              ),
              BoxedIcon(
                //Display Weather Icon
                (DisplayerWeatherIcon(widget.mIcon).displayIcon()),
                color: Colors.black,
                size: 25.h,
              ),
              Text(
                // Display weather status
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
                (DisplayerWeatherIcon(widget.mIcon).displayStatus()).toString(),
              ),
              Text(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 100,
                  ),
                  "${widget.mTemperature}°"),
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
                        "${widget.mWindSpeed}/mph",
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
                        degree: widget.mWindDirection,
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
                          "${widget.mHumidity}"),
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
    );
  }
}

// weather icons from https://erikflowers.github.io/weather-icons/

// TODO : Main Weather Card
// TODO : Search Weather Card
// TODO : Favourites Weather Card



              // ExpansionTile(
              //   //expandedCrossAxisAlignment: CrossAxisAlignment.center,
              //   title: Text(''),
              //   tilePadding: EdgeInsets.all(0),

              //   children: <Widget>[
              //     Text('Big Bang'),
              //     Text('Birth of the Sun'),
              //     Text('Earth is Born'),
              //   ],
              // ),