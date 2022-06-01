import 'package:flutter/material.dart';
import 'package:mobile_computing_assignment/globals.dart';
import 'package:mobile_computing_assignment/weather_card_main.dart';
import 'geolocation.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String latitude = "";
  String longitude = "";

  String location = "";
  String temperature = "";
  String icon = "";
  double windSpeed = 0.0;
  int windDirection = 0;
  int humidity = 0;

// gets user geolocation information
  getCurrentLocation() async {
    final geoposition = await Geolocation().determinePosition();
    setState(() {
      latitude = '${geoposition.latitude}';
      longitude = '${geoposition.longitude}';
    });
  }

  void getLocalWeather() async {
    http.Response response = await http.get(
      Uri.parse(
          "http://api.airvisual.com/v2/nearest_city?lat=$latitude&lon=$longitude&key=$kApiKey"),
    );

    if (response.statusCode == 200) // 200 is http code for success
    {
      String locationInfo = response.body;
      debugPrint(response.body);
      var test = jsonDecode(locationInfo)["data"]["city"];
      print("Json test output  = $test");
      var test2 =
          jsonDecode(locationInfo)["data"]["current"]["pollution"]["ts"];

      // data.current.weather.tp - temperature
      location = jsonDecode(locationInfo)["data"]["city"]; // user
      temperature = jsonDecode(locationInfo)["data"]["current"]["weather"]["tp"]
          .toString();
      icon = jsonDecode(locationInfo)["data"]["current"]["weather"]["ic"];
      windSpeed = jsonDecode(locationInfo)["data"]["current"]["weather"]["ws"];
      windDirection =
          jsonDecode(locationInfo)["data"]["current"]["weather"]["wd"];
      humidity = jsonDecode(locationInfo)["data"]["current"]["weather"]["hu"];
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getLocalWeather();
  }

  @override
  Widget build(BuildContext context) {
    //  when page is first initialised,get user geolocation information
    getLocalWeather();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        // ignore: prefer_const_constructors
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage("lib/images/background (5).jpg"),
              fit: BoxFit.cover),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              MainWeatherCard(location, temperature, icon, windSpeed,
                  windDirection, humidity);
            });
            debugPrint("Weather card pressed");
          },
          child: MainWeatherCard(
              location, temperature, icon, windSpeed, windDirection, humidity),
        ),
      ),
    );
  }
}

// background images from https://wallpaperaccess.com/orange-phoneCenter(
