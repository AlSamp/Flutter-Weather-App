import 'package:flutter/material.dart';

import 'package:weather_icons/weather_icons.dart';

class DisplayerWeatherIcon {
  String mSelectedIcon = "";

  DisplayerWeatherIcon(String icon) {
    mSelectedIcon = icon;
  }

  displayIcon() {
    if (mSelectedIcon == "01d") {
      return WeatherIcons.day_sunny;
    } else if (mSelectedIcon == "01n") {
      return WeatherIcons.night_clear;
    } else if (mSelectedIcon == "02d") {
      return WeatherIcons.day_cloudy;
    } else if (mSelectedIcon == "02n") {
      return WeatherIcons.night_cloudy;
    } else if (mSelectedIcon == "03d") {
      return WeatherIcons.cloud;
    } else if (mSelectedIcon == "04d") {
      return WeatherIcons.cloudy;
    } else if (mSelectedIcon == "09d") {
      return WeatherIcons.showers;
    } else if (mSelectedIcon == "10d") {
      return WeatherIcons.day_showers;
    } else if (mSelectedIcon == "10n") {
      return WeatherIcons.night_alt_showers;
    } else if (mSelectedIcon == "11d") {
      return WeatherIcons.thunderstorm;
    } else if (mSelectedIcon == "13d") {
      return WeatherIcons.snow;
    } else if (mSelectedIcon == "50d") {
      return WeatherIcons.fog;
    } else {
      return WeatherIcons.alien; // error
    }
  }

  displayStatus() {
    if (mSelectedIcon == "01d") {
      return "Clear Sky (day)";
    } else if (mSelectedIcon == "01n") {
      return "Clear Sky (night)";
    } else if (mSelectedIcon == "02d") {
      return "Few Clouds (day)";
    } else if (mSelectedIcon == "02n") {
      return "Few Clouds (night)";
    } else if (mSelectedIcon == "03d") {
      return "Scattered Clouds";
    } else if (mSelectedIcon == "04d") {
      return "Broken Clouds";
    } else if (mSelectedIcon == "09d") {
      return "Shower Rain";
    } else if (mSelectedIcon == "10d") {
      return "Rain (day time)";
    } else if (mSelectedIcon == "10n") {
      return "Rain (night time)";
    } else if (mSelectedIcon == "11d") {
      return "Thunderstorm";
    } else if (mSelectedIcon == "13d") {
      return "Snow";
    } else if (mSelectedIcon == "50d") {
      return "Mist";
    } else {
      return "No status"; // error
    }
  }
}


// Weather Icons - https://erikflowers.github.io/weather-icons/
// Status Codes - https://api-docs.iqair.com/?version=latest#important-notes