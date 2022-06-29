import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String kApiKey = "26eb908b-5e62-4d59-912a-efa993c26362";
List<String> favouritesList = [];
bool checkFavourites(String target) {
  for (int i = 0; i < favouritesList.length; i++) {
    if (target == favouritesList[i]) {
      return true;
    }
  }
  return false;
}

final fireStore = FirebaseFirestore.instance;

void messagesStream() async {
  // listen to all changes with this collection

  await for (var snapshot in fireStore.collection("favourites").snapshots()) {
    // debugPrint("Printing list start");
    //for (var message in snapshot.docs) {
    //  debugPrint(message.data().toString());
    //}
    // debugPrint("Printing list end");
  }
}

String _userKey = "user";

// A class to store user preferences
class UserPreferences {
  static late SharedPreferences _preference;

  static Future init() async {
    _preference = await SharedPreferences.getInstance();
  }

  static Future setLightDarkMode(bool value) async {
    await _preference.setBool(_userKey, value);
  }

// question makk makes it nullable
  static bool getLightDarkMode() {
    return _preference.getBool(_userKey) ??
        false; // start dark mode is == false
  }
}

String gLightBackgroundImage = "lib/images/light(1).jpg";
String gDarkBackgroundImage = "lib/images/background (5).jpg";

// Class that contains light mode and dark mode colours schemes
class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(33, 33, 33, 1),
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.white,
      background: Colors.black,
      onPrimary: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      primaryContainer: Color.fromARGB(176, 158, 158, 158),
      onPrimaryContainer: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      background: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.black,
      surface: Color.fromARGB(174, 33, 72, 243),
      onSurface: Colors.black,
      primaryContainer: Color.fromARGB(59, 33, 72, 243),
      onPrimaryContainer: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}

// Class to Track changes in theme and user preferences
class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  ThemeProvider() {
    toggleTheme(isDarkMode);
  }
  //bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isDarkMode {
    return UserPreferences.getLightDarkMode();
  }

  void toggleTheme(bool isOn) {
    debugPrint("dark Mode toggle = $isOn");
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    UserPreferences.setLightDarkMode(isOn);
    debugPrint("dark Mode toggle = $isOn");
    notifyListeners();
  }
}

// Returns a switch that changes the theme
class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
