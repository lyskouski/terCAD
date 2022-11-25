import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:tercad/main_content.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'terCAD',
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // supportedLocales: AppLocalizations.supportedLocales,
      supportedLocales: [
        Locale('en', ''),
        Locale('pt', ''),
        Locale('de', ''),
        Locale('fr', ''),
      ],
      // home: MyHomePage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    return MaterialPageRoute(
      builder: (context) => getMainContent(context,
        settings.name == '/' ? AppLocalizations.of(context)!.title : settings.name)
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return getMainContent(context, AppLocalizations.of(context)!.title);
  }
}

void main() => runApp(const MyApp());
