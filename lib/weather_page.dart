import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Page"),
      ),
      body: TextButton(
        onPressed: () => {},
        child: Center(
          child: Container(
            color: Colors.purple,
            child: Text("Get Weather"),
          ),
        ),
      ),
    );
  }
}
