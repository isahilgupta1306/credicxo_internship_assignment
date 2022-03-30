import 'package:credicxo_internship_assignment/main.dart';

import 'package:credicxo_internship_assignment/widgets/detailed_track_card.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import '../utils/custom_colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? trackName;
    String? trackId;
    return Scaffold(
      backgroundColor: bgColorDark,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxScrolled) => [
          const SliverAppBar(
            backgroundColor: Colors.transparent,
            floating: true,
            title: Text(
              "Favorites",
            ),
            centerTitle: true,
          )
        ],
        body: ValueListenableBuilder(
            valueListenable: Hive.box(fav).listenable(),
            builder: (context, box, child) {
              List data = List.from(Hive.box(fav).values);

              return DetailedCard()
                  .favoriteTrackCard(context, trackName, trackId, data);
            }),
      ),
    );
  }
}
