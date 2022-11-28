import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const double paddingIndent = 12;
const String errMessage = '[err]';

class BasicTile {
  final String? title;
  final String url;
  final List<BasicTile> tiles;

  const BasicTile({
    required this.title,
    this.url = '/',
    this.tiles = const [],
  });
}

Widget buildMainMenu(BuildContext context, BasicTile tile, {double leftIndent = paddingIndent}) {
  if (tile.tiles.isEmpty) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: leftIndent),
      title: Text(tile.title ?? errMessage),
      onTap: () => Navigator.of(context).pushNamed(tile.url),
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

BasicTile? findTileByUrl(url, context) {
  return _findTileByUrl(url, AppLocalizations.of(context)!.title, getMainMenu(context));
}

BasicTile _findTileByUrl(String url, String? defTitle, List<BasicTile> tiles) {
  BasicTile result = BasicTile(
    title: defTitle,
    url: '/'
  );
  for (final tile in tiles) {
    if (tile.url == url) {
      result = tile;
      break;
    }
    if (tile.tiles.isNotEmpty) {
      var tmp = _findTileByUrl(url, defTitle, tile.tiles);
      if (tmp.url == url) {
        result = tmp;
        break;
      }
    }
  }
  return result;
}

List<BasicTile> getMainMenu(BuildContext context) {
  return <BasicTile>[
    BasicTile(
      title: AppLocalizations.of(context)!.oeuvre,
      url: '/oeuvre',
      tiles: [
        BasicTile(
          title: AppLocalizations.of(context)!.prose,
          url: '/oeuvre/prose',
        ),
        BasicTile(
          title: AppLocalizations.of(context)!.poetry,
          url: '/oeuvre/poetry',
        ),
      ],
    ),
    BasicTile(
      title: AppLocalizations.of(context)!.cognition,
      url: '/cognition',
    ),
    BasicTile(
      title: AppLocalizations.of(context)!.mind,
      url: '/cognition/mind',
      tiles: [
        BasicTile(
          title: AppLocalizations.of(context)!.methods,
          url: '/cognition/mind/methods',
          tiles: [
            BasicTile(
              title: AppLocalizations.of(context)!.sensorModality,
              url: '/cognition/mind/methods/sensor-modality',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.inContent,
              url: '/cognition/mind/methods/in-content',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.memoryOrganization,
              url: '/cognition/mind/methods/memory-organization',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.timeCharacteristics,
              url: '/cognition/mind/methods/time-characteristics',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.presenceOfTarget,
              url: '/cognition/mind/methods/presence-of-target',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.availabilityOfMeans,
              url: '/cognition/mind/methods/availability-of-means',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.methodForStoring,
              url: '/cognition/mind/methods/method-for-storing',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.symbolicMemory,
              url: '/cognition/mind/methods/symbolic-memory',
            ),
          ],
        ),
        BasicTile(
          title: AppLocalizations.of(context)!.objects,
              url: '/cognition/mind/objects',
          tiles: [
            BasicTile(
              title: AppLocalizations.of(context)!.exactSciences,
              url: '/cognition/mind/objects/exact-sciences',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.socialSciences,
              url: '/cognition/mind/objects/social-sciences',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.humanSciences,
              url: '/cognition/mind/objects/human-sciences',
            ),
            BasicTile(
              title: AppLocalizations.of(context)!.musicEducation,
              url: '/cognition/mind/objects/music-education',
            ),
          ]
        ),
      ],
    ),
  ];
}