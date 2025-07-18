// Basic Flutter widget test for Convoy Travel App.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:convoy_travel_app/main.dart';

void main() {
  testWidgets('App launches with login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ConvoyTravelApp());

    // Verify that the login screen is displayed
    expect(find.text('Convoy Travel'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
