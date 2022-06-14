import 'package:flutter/material.dart';
import 'globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

String dropdownValue = 'One';

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: Text("Settings"),
      actions: [
        ChangeThemeButtonWidget(),
        //ChangeBackGroundWidget(), //TODO : Make sure this works, will need ChangeNotifierProvider
      ],
    ));
  }
}


        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: const AssetImage("lib/images/background (5).jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),