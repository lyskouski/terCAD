import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tercad/main.dart';

void main() {
  testWidgets(
    'Given main page When navigation is clicked Then shown 3-options dropdown',
    (WidgetTester tester
  ) async {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final locale = await AppLocalizations.delegate.load(const Locale('en', ''));
    await tester.pumpWidget(const MyApp());

    // Verify that list is closed, and nothing is shown.
    expect(find.text(locale.oeuvre), findsNothing);
    expect(find.text('Cognition'), findsNothing);
    expect(find.text('Mind'), findsNothing);

    // Tap the navigation icon
    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();

    // Verify that content appeared
    expect(find.text('Oeuvre'), findsOneWidget);
    expect(find.text('Cognition'), findsOneWidget);
    expect(find.text('Mind'), findsOneWidget);
  });
}
