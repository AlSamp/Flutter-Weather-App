//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'search_states_page.dart';
import 'package:sizer/sizer.dart';
import 'status_error_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> apiCountries = []; // empty list
  late int numCountries = 0;

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StatusErrorPage(
            "Search Page",
            response.statusCode.toString(),
          ),
        ),
      );
    }

    setState(() {}); // this update the screen with the list of countries
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextButton(
          onPressed: () {
            setState(() {
              getCountries();
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Country Selection",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
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
    );
  }
}

//print('${parsedJson.runtimeType} : $parsedJson');

