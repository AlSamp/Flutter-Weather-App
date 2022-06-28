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
  String mStatus = "";
  void setDeafultCardVariables() {
    if (widget.mLocation == "") {
      widget.mLocation = "";
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
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(
              3.0.h,
            ),
          ),
          child: Column(
            children: [
              Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 28.sp,
                  ),
                  "${widget.mLocation}"),
              SizedBox(
                height: 1,
                width: 50.h,
                child: Container(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              BoxedIcon(
                //Display Weather Icon
                (DisplayerWeatherIcon(widget.mIcon).displayIcon()),
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 23.h,
              ),
              Text(
                // Display weather status
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                (mStatus = DisplayerWeatherIcon(widget.mIcon).displayStatus())
                    .toString(),
              ),
              Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 80.sp,
                  ),
                  "${widget.mTemperature}°"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Display wind
                  Column(
                    children: [
                      BoxedIcon(
                        WeatherIcons.strong_wind,
                        size: 6.5.h,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      Text(
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 13.sp,
                        ),
                        "${widget.mWindSpeed}/mph",
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 11.sp,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        "Windspeed",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      WindIcon(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        degree: widget.mWindDirection,
                        size: 8.6.h,
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 13.sp,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        "Wind Direction",
                      ),
                    ],
                  ),
                  Column(
                    //Display humidity
                    children: [
                      BoxedIcon(
                        WeatherIcons.humidity,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        size: 4.75.h,
                      ),
                      Text(
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 28.sp,
                          ),
                          "${widget.mHumidity}"),
                      Text(
                        style: TextStyle(
                          fontSize: 11.sp,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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