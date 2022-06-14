import 'package:flutter/material.dart';
import 'package:mobile_computing_assignment/globals.dart';
import 'package:provider/provider.dart';
import 'page_navigation_bar.dart';
import 'package:sizer/sizer.dart';
import 'globals.dart';

Future main() async {
  // made Future for shared preferences
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider; // Called to set shared Preferences
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Sizer(
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
