import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tercad/main_menu.dart';

Scaffold getMainContent(BuildContext context, title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(
      child: Text(AppLocalizations.of(context)!.missingContent),
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 42.0,
            child: DrawerHeader(
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.all(paddingIndent),
              child: Text(AppLocalizations.of(context)!.navigation),
            ),
          ),
          ...getMainMenu(context).map((tile) => buildMainMenu(context, tile)).toList()
        ],
      ),
    ),
  );
}