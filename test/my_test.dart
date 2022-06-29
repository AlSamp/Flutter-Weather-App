// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_computing_assignment/weather_card_main.dart';
import 'package:sizer/sizer.dart';

void main() {
  testWidgets('Weather card ', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester
        .pumpWidget(MainWeatherCard("location", "123", "50d", 0.123, 20, 123));

    final locationFinder = find.text("location");
    final temperatureFinder = find.text("123");
    final iconFinder = find.text("50d");
    final windSpeedFinder = find.text("0.123");
    final windDirectionFinder = find.text("20");
    final humidityFinder = find.text("123");

    expect(locationFinder, findsOneWidget);
    expect(temperatureFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(windSpeedFinder, findsOneWidget);
    expect(windDirectionFinder, findsOneWidget);
    expect(humidityFinder, findsOneWidget);
  });
}
