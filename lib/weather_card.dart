import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'display_weather_icons.dart';

class MainWeatherCard extends StatelessWidget {
  late String mLocation;
  //late String mWeatherStatus;
  late String mTemperature;
  late String mIcon;

  MainWeatherCard(String location, String temperature, String icon) {
    mLocation = location;
    //mWeatherStatus = weatherStatus;
    mTemperature = temperature;
    mIcon = icon;
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
                (DisplayerWeatherIcon(mIcon)
                    .displayIcon()), //WeatherIcons.cloudy,
                size: 200,
              ),
              Text(
                  style: TextStyle(fontSize: 25),
                  (DisplayerWeatherIcon(mIcon).displayStatus()).toString()),
              Text(style: TextStyle(fontSize: 50), "$mTemperature°"),
              ExpansionTile(
                //expandedCrossAxisAlignment: CrossAxisAlignment.center,
                title: Text(''),
                tilePadding: EdgeInsets.all(0),

                children: <Widget>[
                  Text('Big Bang'),
                  Text('Birth of the Sun'),
                  Text('Earth is Born'),
                ],
              ),
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