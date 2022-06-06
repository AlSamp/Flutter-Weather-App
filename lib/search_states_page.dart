import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // clarify function origin
import 'dart:convert'; //json conversion
import 'globals.dart';
import 'search_cites_page.dart';
import 'package:sizer/sizer.dart';
import 'status_error_page.dart';

class SearchStatesPage extends StatefulWidget {
  late String mSelectedCountry;

  SearchStatesPage(String country) {
    mSelectedCountry = country;
  }

  @override
  State<SearchStatesPage> createState() => _SearchStatesPageState();
}

class _SearchStatesPageState extends State<SearchStatesPage> {
  //_SearchStatesPageState(String selectedCountry) {
  //  mSelectedCountry = selectedCountry;
  //}
  List<String> apiStates = []; // empty list
  late int numStates = 0;
  late String mCountry = widget.mSelectedCountry;
  void countryCheck() {
    if (mCountry == "United Kingdom") {
      mCountry = "UK";
    }
  }

  void getStates() async {
    countryCheck(); // check that the country is correct for json
    http.Response response = await http.get(
      Uri.parse(
          "http://api.airvisual.com/v2/states?country=$mCountry&key=$kApiKey"),
    );

    if (response.statusCode == 200) // 200 is http code for success
    {
      final states = response.body;
      debugPrint(response.body);
      var test = jsonDecode(states)["data"][0]["state"];
      debugPrint("Json country test output  = $test");

      for (int i = 0; i < 200; i++) {
        try {
          print(jsonDecode(states)["data"][i]["country"]);
          apiStates.add(jsonDecode(states)["data"][i]["state"]);
          numStates++;
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
            "Search States Page",
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
    getStates();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextButton(
          onPressed: () {
            setState(() {
              getStates();
              debugPrint("State Page Refresh Button Pressed");
            });
          },
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  //maxLines: 1,
                  //softWrap: false,
                  "States of $mCountry",
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
        itemCount: numStates,
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
                          SearchCitiesPage(mCountry, apiStates[index]),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(apiStates[index]),
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
