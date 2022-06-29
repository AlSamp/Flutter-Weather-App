import 'package:flutter/material.dart';
import 'package:mobile_computing_assignment/globals.dart';
import 'package:provider/provider.dart';
import 'screen_navigation.dart';
import 'package:sizer/sizer.dart';
import 'globals.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  // made Future for shared preferences
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // start up firebase
  await UserPreferences.init(); // remember user preferences

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider; // Called to set shared Preferences
    return ChangeNotifierProvider(
      // everytime there is a change in theme it will happen across the entire app
      create: (context) => ThemeProvider(),
      child: Sizer(
        // Sizer for consistent screen dimensions across phones
        builder: (context, orientation, deviceType) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: ScreenNavigation());
        },
      ),
    );
  }
}
