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
    await tester.tap(find.text('Try the chat preview'));
    await tester.pumpAndSettle();

    expect(find.text('Preview only — messages are not saved.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Hi there');
    await tester.tap(find.byTooltip('Send message'));
    await tester.pump();

    expect(find.text('Hi there'), findsOneWidget);
  });

  testWidgets('registration validates password confirmation', (tester) async {
    await tester.pumpWidget(const OnlyUsApp());
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(1), 'a@b.com');
    await tester.enterText(fields.at(2), 'password123');
    await tester.enterText(fields.at(3), 'password456');
    final confirmationField = tester.widget<TextFormField>(fields.at(3));
    expect(
      confirmationField.validator!('password456'),
      'Passwords do not match.',
    );
    await tester.ensureVisible(find.byType(FilledButton));
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match.'), findsOneWidget);
  });
}
