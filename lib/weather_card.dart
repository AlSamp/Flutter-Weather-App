import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'display_weather_icons.dart';

class MainWeatherCard extends StatelessWidget {
  late String mLocation;
  //late String mWeatherStatus;
  late String mTemperature;
  late String mIcon;
  late double mWindSpeed;
  late int mWindDirection;
  late int mHumidity;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: [
              Text(style: TextStyle(fontSize: 30), "$mLocation"),
              SizedBox(
                height: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
              BoxedIcon(
                (DisplayerWeatherIcon(mIcon) //Display Weather Icon
                    .displayIcon()),
                size: 200,
              ),
              Text(
                // Display weather status
                style: TextStyle(fontSize: 25),
                (DisplayerWeatherIcon(mIcon).displayStatus()).toString(),
              ),
              Text(style: TextStyle(fontSize: 100), "$mTemperature°"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      BoxedIcon(
                        WeatherIcons.strong_wind,
                        size: 50,
                      ),
                      Text(style: TextStyle(fontSize: 20), "$mWindSpeed/mph"),
                      Text("Windspeed"),
                    ],
                  ),
                  Column(
                    children: [
                      WindIcon(
                        degree: mWindDirection,
                        size: 65,
                      ),
                      Text("Wind Direction"),
                    ],
                  ),
                  Column(
                    children: [
                      BoxedIcon(
                        WeatherIcons.humidity,
                        size: 40,
                      ),
                      Text(style: TextStyle(fontSize: 30), "$mHumidity"),
                      Text("Humidity"),
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