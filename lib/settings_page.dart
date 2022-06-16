import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

List<String> options = ["Toggle Dark/Light Mode"];

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        title: Text(
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
            ),
            "Settings"),
        actions: [
          //ChangeThemeButtonWidget(),
          //ChangeBackGroundWidget(), //TODO : Make sure this works, will need ChangeNotifierProvider
        ],
      ),
      body: Card(
        child: Row(
          children: [
            Text(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18.sp),
                "  Toggle Light/Dark Mode"),
            Spacer(),
            ChangeThemeButtonWidget(),
          ],
        ),
      ),
    );
  }
}


        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: const AssetImage("lib/images/background (5).jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),