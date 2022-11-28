import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

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
}
