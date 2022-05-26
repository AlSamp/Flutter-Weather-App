import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key}) : super(key: key);

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
              Text(style: TextStyle(fontSize: 30), "Location"),
              SizedBox(
                height: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
              BoxedIcon(
                WeatherIcons.rain,
                size: 200,
              ),
              Text(style: TextStyle(fontSize: 25), "Sunny"),
              Text(style: TextStyle(fontSize: 50), "16°"),
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