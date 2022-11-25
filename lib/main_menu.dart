import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tercad/main_content.dart';

const double paddingIndent = 12;
const String errMessage = '[err]';

class BasicTile {
  final String? title;
  final Function(BuildContext, String) route;
  final List<BasicTile> tiles;

  const BasicTile({
    required this.title,
    this.route = getMainContent,
    this.tiles = const [],
  });
}

Widget buildMainMenu(BuildContext context, BasicTile tile, {double leftIndent = paddingIndent}) {
  if (tile.tiles.isEmpty) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: leftIndent),
      title: Text(tile.title ?? errMessage),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => tile.route(context, tile.title ?? errMessage)),
      ),
    );
  } else {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: leftIndent),
    //  trailing: const SizedBox.shrink(),
    //  leading: const Icon(Icons.keyboard_arrow_right_outlined),
      title: Text(tile.title ?? errMessage),
      children: tile.tiles.map((tile) => buildMainMenu(context, tile, leftIndent: paddingIndent + leftIndent)).toList(),
    );
  }
}

List<BasicTile> getMainMenu(BuildContext context) {
  return <BasicTile>[
    BasicTile(
      title: AppLocalizations.of(context)!.oeuvre,
      tiles: [
        BasicTile(
          title: AppLocalizations.of(context)!.prose,
        ),
        BasicTile(
          title: AppLocalizations.of(context)!.poetry,
        ),
      ],
    ),
    BasicTile(
      title: AppLocalizations.of(context)!.cognition,
    ),
    BasicTile(
      title: AppLocalizations.of(context)!.mind,
      tiles: [
        BasicTile(
          title: AppLocalizations.of(context)!.methods,
          tiles: [
            BasicTile(
              title: AppLocalizations.of(context)!.sensorModality,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.inContent,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.memoryOrganization,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.timeCharacteristics,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.presenceOfTarget,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.availabilityOfMeans,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.methodForStoring,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.symbolicMemory,
            ),
          ],
        ),
        BasicTile(
          title: AppLocalizations.of(context)!.objects,
          tiles: [
            BasicTile(
              title: AppLocalizations.of(context)!.exactSciences,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.socialSciences,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.humanSciences,
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.musicEducation,
            ),
          ]
        ),
      ],
    ),
  ];
}