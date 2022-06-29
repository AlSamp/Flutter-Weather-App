import 'package:flutter/material.dart';

class StatusErrorPage extends StatelessWidget {
  StatusErrorPage(String page, String errorCode) {
    mPage = page;
    mErrorCode = errorCode;
  }
  late String mErrorCode;
  late String mPage;

// Return error code
  String errorCode() {
    return "Status Code : $mErrorCode.";
  }

// Display the correct error message depending on status code
  String errorMessage(String errorCode) {
    if (errorCode == "400") {
      return "Bad request has been made. Most likely incorrect api call.";
    } else if (errorCode == "404") {
      return "No internet connection.";
    } else if (errorCode == "429") {
      return "Too many requests made, please wait a moment and try again by refreshing the page.";
    } else if (errorCode == "Invalid Option") {
      return "Selected item has been removed, please refresh the page";
    } else {
      return "An error has occured.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("$mPage Error"),
      content: Text(
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          errorMessage(mErrorCode)),
      actions: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  "Okay"),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  errorCode()),
            ),
          ],
        )
      ],
    );
  }
}
