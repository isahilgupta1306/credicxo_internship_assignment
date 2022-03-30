import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../main.dart';
import '../screens/track_details.dart';
import '../utils/custom_colors.dart';
import '../utils/fade_route.dart';

class DetailedCard {
  Widget detailHomeCard(
    BuildContext context,
    String? trackName,
    String? artistName,
    String? albumName,
    String? trackId,
    int? hasLyrics,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FadeRoute(page: TrackDetails(trackId: trackId)),
        );
      },
      child: ListBody(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12),
            child: Container(
              decoration: const BoxDecoration(
                color: cardColorbgColorDark,
                borderRadius: BorderRadius.all(Radius.circular(14)),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(0, 1),
                      color: primaryColor)
                ],
              ),
              margin: const EdgeInsets.only(right: 5, left: 5, top: 10),
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      CupertinoIcons.music_note,
                      color: primaryColor,
                    ),
                    title: Text(
                      trackName!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: white.withOpacity(0.9),
                      ),
                    ),
                    subtitle: Text(
                      artistName!,
                      style: GoogleFonts.openSans(
                          color: primaryColorLight,
                          fontStyle: FontStyle.italic),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Divider(
                    color: primaryColorDark,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      bottom: 14,
                    ),
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Album :",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColorLight.withOpacity(0.7)),
                          ),
                          Text(
                            albumName!,
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                height: 1.5,
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget favoriteTrackCard(BuildContext context, String? trackName,
      String? trackId, List<dynamic> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, i) {
        trackName = data[i];
        trackId = Hive.box(fav).keyAt(i);

        return GestureDetector(
          onTap: () {
            trackId = Hive.box(fav).keyAt(i);
            Navigator.push(
              context,
              FadeRoute(page: TrackDetails(trackId: trackId)),
            );
          },
          child: ListBody(
            children: [
              Dismissible(
                direction: DismissDirection.startToEnd,
                key: UniqueKey(),
                background: Container(
                  color: primaryColor,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Remove From \nFavorites',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  Hive.box(fav).deleteAt(i);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Removed from Favorites"),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: cardColorbgColorDark,
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 1),
                            color: primaryColor)
                      ],
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.music_note,
                              color: primaryColor,
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: royalRed,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Removed from the Favorites"),
                                ));
                                Hive.box(fav).deleteAt(i);
                              },
                            ),
                            title: Text(
                              trackName!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: white.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
