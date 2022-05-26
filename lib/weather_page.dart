import 'package:flutter/material.dart';
import 'package:mobile_computing_assignment/globals.dart';
import 'geolocation.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'package:weather_icons/weather_icons.dart';

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

      location = jsonDecode(locationInfo)["data"]["city"]; // user
      // data.current.weather.tp - temperature
      temperature = jsonDecode(locationInfo)["data"]["current"]["weather"]["tp"]
          .toString();

      // data.current.weather.ic -  screen picture to be disvar

      print("Json test2 ouptut = $test2");
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  @override
  //  when page is first initialised,get user geolocation information
  void initState() {
    super.initState();
    getCurrentLocation();
    getLocalWeather();
  }

  @override
  Widget build(BuildContext context) {
    getLocalWeather();
    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: AppBar(
      //  title: const Text("Weather Page"),
      //),
      // TODO : Design display cards and output data

      body: Container(
        // ignore: prefer_const_constructors
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage("lib/images/background (6).jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(),
              Center(child: Text(location)),
              Text(temperature),
              TextButton(
                onPressed: () => {
                  getLocalWeather(),
                },
                child: Container(
                  child: const Text("Get Weather"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// background images from https://wallpaperaccess.com/orange-phone