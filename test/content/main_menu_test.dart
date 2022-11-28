import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tercad/content/main_menu.dart';

void main() {
  testWidgets(
    'Given EN localization When `title` is taken Then aligned with `terCAD`',
    (WidgetTester tester
  ) async {
    final file = File('./lib/l10n/app_en.arb').readAsStringSync();
    final lang = jsonDecode(file) as Map<String, dynamic>;
    expect(lang['title'], equals('terCAD'));
  });

  testWidgets(
    'Given localization When all languages are taken Then they are aligned in keys',
    (WidgetTester tester
  ) async {
    final fileEn = File('./lib/l10n/app_en.arb').readAsStringSync();
    final langEn = jsonDecode(fileEn) as Map<String, dynamic>;
    final fileDe = File('./lib/l10n/app_de.arb').readAsStringSync();
    final langDe = jsonDecode(fileDe) as Map<String, dynamic>;
    final fileFr = File('./lib/l10n/app_fr.arb').readAsStringSync();
    final langFr = jsonDecode(fileFr) as Map<String, dynamic>;
    final filePt = File('./lib/l10n/app_pt.arb').readAsStringSync();
    final langPt = jsonDecode(filePt) as Map<String, dynamic>;

    expect(langEn.keys, equals(langDe.keys));
    expect(langEn.keys, equals(langFr.keys));
    expect(langEn.keys, equals(langPt.keys));
  });

  testWidgets(
    'Given URL When title is requested Then given a search result',
    (WidgetTester tester
  ) async {
     await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          var actual = findTileByUrl('/oeuvre/prose', context);
          expect(actual, AppLocalizations.of(context)!.prose);
          // The builder function must return a widget
          return Container();
        },
      ),
    );
  });
}
