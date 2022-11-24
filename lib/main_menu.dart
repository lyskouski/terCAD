import 'package:flutter/material.dart';

const double paddingIndent = 12;

class BasicTile {
  final String title;
  final List<BasicTile> tiles;

  const BasicTile({
    required this.title,
    this.tiles = const [],
  });
}

Widget buildMainMenu(BuildContext context, BasicTile tile, {double leftIndent = paddingIndent}) {
  if (tile.tiles.isEmpty) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: leftIndent),
      title: Text(tile.title),
      onTap: () => {
        // ...
      },
    );
  } else {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: leftIndent),
    //  trailing: const SizedBox.shrink(),
    //  leading: const Icon(Icons.keyboard_arrow_right_outlined),
      title: Text(tile.title),
      children: tile.tiles.map((tile) => buildMainMenu(context, tile, leftIndent: paddingIndent + leftIndent)).toList(),
    );
  }
}

final mainMenu = <BasicTile>[
  const BasicTile(
    title: 'Oeuvre',
    tiles: [
      BasicTile(title: 'Prose'),
      BasicTile(title: 'Poetry'),
    ],
  ),
  const BasicTile(
    title: 'Cognition',
  ),
  const BasicTile(
    title: 'Mind',
    tiles: [
      BasicTile(
        title: 'Methods',
        tiles: [
          BasicTile(
            title:'By sensory modality',
          ),
          BasicTile(
            title: 'In Content',
          ),
          BasicTile(
            title: 'Memory Organization',
          ),
          BasicTile(
            title: 'Time Characteristics',
          ),
          BasicTile(
            title: 'Presence of Target',
          ),
          BasicTile(
            title: 'Availability of Means',
          ),
          BasicTile(
            title: 'Method for Storing',
          ),
          BasicTile(
            title: 'Symbolic Memory',
          ),
        ],
      ),
      BasicTile(
        title: 'Objects',
        tiles: [
          BasicTile(
            title:'Exact Sciences',
          ),
          BasicTile(
            title:'Social Sciencies',
          ),
          BasicTile(
            title:'Humanities',
          ),
          BasicTile(
            title:'Music Education',
          ),
        ]
      ),
    ],
  ),
];
