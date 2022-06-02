//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'search_states_page.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> apiCountries = []; // empty list
  late int numCountries = 0;
  //Map<String, dynamic> apiCountries = {};
  //var apiCountries;

  void getCountries() async {
    http.Response response = await http.get(
      Uri.parse("http://api.airvisual.com/v2/countries?key=$kApiKey"),
    );

    if (response.statusCode == 200) // 200 is http code for success
    {
      final country = response.body;
      debugPrint(response.body);
      var test = jsonDecode(country)["data"][0]["country"];
      debugPrint("Json country test output  = $test");

      for (int i = 0; i < 200; i++) {
        try {
          print(jsonDecode(country)["data"][i]["country"]);
          apiCountries.add(jsonDecode(country)["data"][i]["country"]);
          numCountries++;
        } catch (error) {
          // There will be a read access violation so break the for loop
          break;
        }
      }
    } else {
      debugPrint(response.statusCode.toString());
    }

    setState(() {}); // this update the screen with the list of countries
  }

  final ScrollController _controllerOne = ScrollController();
  @override
  void initState() {
    super.initState();
    getCountries();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Countries",
        ),
        backgroundColor: Colors.black,
      ),
      body: Scrollbar(
        //controller: _controllerOne,
        //thumbVisibility: true,
        //trackVisibility: true,
        //thickness: 0.5.h,
        child: ListView.builder(
          itemCount: numCountries,
          itemBuilder: (BuildContext, index) {
            return TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchStatesPage(apiCountries[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(apiCountries[index]),
                    trailing: Text("..."),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//print('${parsedJson.runtimeType} : $parsedJson');

