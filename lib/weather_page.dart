import 'package:flutter/material.dart';
import 'package:mobile_computing_assignment/globals.dart';
import 'package:mobile_computing_assignment/weather_card_main.dart';
import 'geolocation.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'status_error_page.dart';
import 'package:sizer/sizer.dart';
import 'globals.dart';
import 'package:share_plus/share_plus.dart';

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
    try {
      getCurrentLocation();

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
        temperature = jsonDecode(locationInfo)["data"]["current"]["weather"]
                ["tp"]
            .toString();
        icon = jsonDecode(locationInfo)["data"]["current"]["weather"]["ic"];
        windSpeed = jsonDecode(locationInfo)["data"]["current"]["weather"]["ws"]
            .toDouble();
        windDirection =
            jsonDecode(locationInfo)["data"]["current"]["weather"]["wd"];
        humidity = jsonDecode(locationInfo)["data"]["current"]["weather"]["hu"];
      } else {
        debugPrint(response.statusCode.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatusErrorPage(
              "Weather Page",
              response.statusCode.toString(),
            ),
          ),
        );
      }
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

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    //getLocalWeather();
  }

  @override
  Widget build(BuildContext context) {
    //  when page is first initialised,get user geolocation information
    //getLocalWeather();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                if (location != "") {
                  Share.share(
                      "Today in $location the temperature is $temperature°",
                      subject: "Local Weather");
                }
                debugPrint("Share button pressed");
              },
              child: Icon(
                Icons.share,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                "Local Weather",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Icon(
                    Icons.refresh,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    setState(() {
                      //getCurrentLocation();
                      getLocalWeather();
                      MainWeatherCard;
                      MainWeatherCard(location, temperature, icon, windSpeed,
                          windDirection, humidity);
                    });
                    debugPrint("Weather Refresh button pressed");
                  },
                ),
              ],
            ),
          ],
        ),

        ///
      ),
      body: Container(
        // ignore: prefer_const_constructors
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          image: DecorationImage(
              // check for dark mode or light mode and change background accordinly
              image: AssetImage(
                isDarkMode ? gDarkBackgroundImage : gLightBackgroundImage,
              ),
              fit: BoxFit.cover),
        ),
        child: MainWeatherCard(
          location,
          temperature,
          icon,
          windSpeed,
          windDirection,
          humidity,
        ),
      ),
    );
  }
}

// background images from https://wallpaperaccess.com/orange-phoneCenter(

