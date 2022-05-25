import 'package:flutter/material.dart';
import 'package:mobile_computing_assignment/globals.dart';
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
  var url;

// gets user geolocation information
  getCurrentLocation() async {
    final geoposition = await Geolocation().determinePosition();
    setState(() {
      latitude = '${geoposition.latitude}';
      longitude = '${geoposition.longitude}';
    });
  }

  void getWeather() async {
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
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  @override
  //  when page is first initialised,get user geolocation information
  void initState() {
    super.initState();
    getCurrentLocation();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    getWeather();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Page"),
      ),
      body: Column(
        children: [
          Text(longitude),
          Text(latitude),
          //Text(url.toString()),
          TextButton(
            onPressed: () => {
              getCurrentLocation(),
            },
            child: Center(
              child: Container(
                color: Colors.purple,
                child: const Text("Get Weather"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
