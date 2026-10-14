import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:only_us/app.dart';

void main() {
  testWidgets('splash navigates to the login screen', (tester) async {
    await tester.pumpWidget(const OnlyUsApp());

    expect(find.text('A little space for the two of you.'), findsOneWidget);
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Sign in to Only Us'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('chat preview displays a submitted message', (tester) async {
    await tester.pumpWidget(const OnlyUsApp());
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Explore the app structure'));
    await tester.pumpAndSettle();

    expect(find.text('Preview only — messages are not saved.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Hi there');
    await tester.tap(find.byTooltip('Send message'));
    await tester.pump();

    expect(find.text('Hi there'), findsOneWidget);
  });
}
