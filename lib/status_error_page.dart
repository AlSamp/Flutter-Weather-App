import 'package:flutter/material.dart';

class StatusErrorPage extends StatelessWidget {
  StatusErrorPage(String page, String errorCode) {
    mPage = page;
    mErrorCode = errorCode;
  }
  late String mErrorCode;
  late String mPage;

  String errorMessage() {
    return "Status Code : $mErrorCode.";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("$mPage Error"),
      content: Text(errorMessage()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Okay"),
        )
      ],
    );
  }
}
