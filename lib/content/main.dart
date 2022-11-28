import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:tercad/content/main_menu.dart';

Scaffold getMainContent(BuildContext context, String? url) {
  var urlBreadCrumbs = (url ?? '/').split('/');
  String? title = findTileByUrl(url, context)?.title;
  var locale = AppLocalizations.of(context)!.localeName;
  return Scaffold(
    appBar: AppBar(title: Text(title ?? '')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BreadCrumb.builder(
            itemCount: urlBreadCrumbs.length - 1,
            builder: (index) {
              String url = urlBreadCrumbs.sublist(0, index + 1).join('/');
              if (url == '') {
                url = '/';
              }
              String? titleBreadCrumb = findTileByUrl(url, context)?.title;
              return BreadCrumbItem(
                content: Text(titleBreadCrumb ?? ''),
                onTap: () => Navigator.of(context).pushNamed(url)
              );
            },
            divider: const Icon(Icons.chevron_right),
            overflow: const WrapOverflow(
              keepLastDivider: false,
              direction: Axis.horizontal,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString('./assets/content/${url}_${locale}.md'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data ?? '');
                }
                return Container();
              }
            ),
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