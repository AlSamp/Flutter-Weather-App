import 'package:flutter/material.dart';
import 'geolocation.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String latitude = "";
  String longitude = "";

// gets user geolocation information
  getCurrentLocation() async {
    final geoposition = await Geolocation().determinePosition();
    setState(() {
      latitude = '${geoposition.latitude}';
      longitude = '${geoposition.longitude}';
    });
  }

  @override
  void initState() {
    //  when page is first initialised,get user geolocation information
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Page"),
      ),
      body: Column(
        children: [
          Text(longitude),
          Text(latitude),
          TextButton(
            onPressed: () => {getCurrentLocation()},
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
