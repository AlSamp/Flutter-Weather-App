import 'package:weather_icons/weather_icons.dart';

class DisplayerWeatherIcon {
  String mSelectedIcon = "";

  DisplayerWeatherIcon(String icon) {
    mSelectedIcon = icon;
  }

  // List of iQair icon codes
  List<String> iconCodes = [
    "01d", // 00
    "01n", // 01
    "02d", // 02
    "02n", // 03
    "03d", // 04
    "03n", // 05
    "04d", // 06
    "04n", // 07
    "09d", // 08
    "09n", // 09
    "10d", // 10
    "10n", // 11
    "11d", // 12
    "11n", // 13
    "13d", // 14
    "13n", // 15
    "50d", // 16
    "50n" // 17
  ];

  List<String> weatherStatus = [
    "Clear Sky (day)", //00
    "Clear Sky (night)", //01
    "Few Clouds (day)", //02
    "Few Clouds (night)", //03
    "Scattered Clouds (day)", //04
    "Scattered Clouds (night)", //05
    "Broken Clouds (day)", //06
    "Broken Clouds (night)", //07
    "Shower Rain(day)", //08
    "Shower Rain(night)", //09
    "Rain (day time)", //10
    "Rain (night time)", //11
    "Thunderstorm (day)", //12
    "Thunderstorm (night)", //13
    "Snow (day)", //14
    "Snow (night)", //15
    "Mist (day)", //16
    "Mist (night)" //17
  ];

  // Recieve status code and display the appropriate icon

  displayIcon() {
    if (mSelectedIcon == iconCodes[0]) {
      return WeatherIcons.day_sunny;
    } else if (mSelectedIcon == iconCodes[1]) {
      return WeatherIcons.night_clear;
    } else if (mSelectedIcon == iconCodes[2]) {
      return WeatherIcons.day_cloudy;
    } else if (mSelectedIcon == iconCodes[3]) {
      return WeatherIcons.night_alt_cloudy;
    } else if (mSelectedIcon == iconCodes[4]) {
      return WeatherIcons.cloud;
    } else if (mSelectedIcon == iconCodes[5]) {
      return WeatherIcons.cloud;
    } else if (mSelectedIcon == iconCodes[6]) {
      return WeatherIcons.cloudy;
    } else if (mSelectedIcon == iconCodes[7]) {
      return WeatherIcons.cloudy;
    } else if (mSelectedIcon == iconCodes[8]) {
      return WeatherIcons.showers;
    } else if (mSelectedIcon == iconCodes[9]) {
      return WeatherIcons.showers;
    } else if (mSelectedIcon == iconCodes[10]) {
      return WeatherIcons.day_showers;
    } else if (mSelectedIcon == iconCodes[11]) {
      return WeatherIcons.night_alt_showers;
    } else if (mSelectedIcon == iconCodes[12]) {
      return WeatherIcons.thunderstorm;
    } else if (mSelectedIcon == iconCodes[13]) {
      return WeatherIcons.thunderstorm;
    } else if (mSelectedIcon == iconCodes[14]) {
      return WeatherIcons.snow;
    } else if (mSelectedIcon == iconCodes[15]) {
      return WeatherIcons.snow;
    } else if (mSelectedIcon == iconCodes[16]) {
      return WeatherIcons.fog;
    } else if (mSelectedIcon == iconCodes[17]) {
      return WeatherIcons.fog;
    } else {
      return WeatherIcons.refresh; // error
    }
  }

  // Recieve status code and display the appropriate weather status

  displayStatus() {
    if (mSelectedIcon == iconCodes[0]) {
      return weatherStatus[0];
    } else if (mSelectedIcon == iconCodes[1]) {
      return weatherStatus[1];
    } else if (mSelectedIcon == iconCodes[2]) {
      return weatherStatus[2];
    } else if (mSelectedIcon == iconCodes[3]) {
      return weatherStatus[3];
    } else if (mSelectedIcon == iconCodes[4]) {
      return weatherStatus[4];
    } else if (mSelectedIcon == iconCodes[5]) {
      return weatherStatus[5];
    } else if (mSelectedIcon == iconCodes[6]) {
      return weatherStatus[6];
    } else if (mSelectedIcon == iconCodes[7]) {
      return weatherStatus[7];
    } else if (mSelectedIcon == iconCodes[8]) {
      return weatherStatus[8];
    } else if (mSelectedIcon == iconCodes[9]) {
      return weatherStatus[9];
    } else if (mSelectedIcon == iconCodes[10]) {
      return weatherStatus[10];
    } else if (mSelectedIcon == iconCodes[11]) {
      return weatherStatus[11];
    } else if (mSelectedIcon == iconCodes[12]) {
      return weatherStatus[12];
    } else if (mSelectedIcon == iconCodes[13]) {
      return weatherStatus[13];
    } else if (mSelectedIcon == iconCodes[14]) {
      return weatherStatus[14];
    } else if (mSelectedIcon == iconCodes[15]) {
      return weatherStatus[15];
    } else if (mSelectedIcon == iconCodes[16]) {
      return weatherStatus[16];
    } else if (mSelectedIcon == iconCodes[17]) {
      return weatherStatus[17];
    } else {
      return "No status"; // error
    }
  }
}

// Weather Icons - https://erikflowers.github.io/weather-icons/
// Status Codes - https://api-docs.iqair.com/?version=latest#important-notes
