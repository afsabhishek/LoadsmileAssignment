// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:assignment/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('Choose date', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
      home: HomePage(),

    ));

    expect(find.text('Choose Date'), findsOneWidget);
    await tester.tap(find.text('Choose Date'));

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();


    /*Navigator.pushNamed(context, '/ingredients',
        arguments: IngredientsScreenArgs(selectedDate));*/
  });
}
