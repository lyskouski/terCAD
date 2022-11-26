import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

import 'package:tercad/main_menu.dart';

Scaffold getMainContent(BuildContext context, String? url) {
  var urlBreadCrumbs = (url ?? '').split('/');
  String? title = url == '/' ? AppLocalizations.of(context)!.title : url;
  return Scaffold(
    appBar: AppBar(title: Text(title ?? '')),
    body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadCrumb.builder(
                itemCount: urlBreadCrumbs.length,
                builder: (index) {
                  return BreadCrumbItem(content: Text(urlBreadCrumbs[index]));
                },
                divider: const Icon(Icons.chevron_right),
                overflow: const WrapOverflow(
                  keepLastDivider: false,
                  direction: Axis.horizontal,
                ),
              ),
              Center(
                child: Text(AppLocalizations.of(context)!.missingContent),
              ),
            ]
          ),
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