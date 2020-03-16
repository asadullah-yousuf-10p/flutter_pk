// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_pk/screens/onboarding/onboarding.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: OnboardingPage(),
        ),
      );

      expect(
          find.byKey(
            Key('centerKey'),
          ),
          findsOneWidget);

      expect(find.text('Swipe left to proceed'), findsOneWidget);

      expect(
          AnimatedCrossFade(
              firstChild: Text('Swipe left to proceed'),
              secondChild: Text('Please wait ...'),
              crossFadeState: CrossFadeState.showSecond,
              duration: Duration(milliseconds: 800)),
          findsNothing);

     // expect(find.text('Please wait ...'), findsOneWidget);
    });
  });
}
