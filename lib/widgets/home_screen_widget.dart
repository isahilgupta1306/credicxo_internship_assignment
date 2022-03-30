import 'package:flutter/material.dart';

import '../api services/models/track_name_model.dart';
import 'detailed_track_card.dart';
import 'lyrics_validator.dart';

class HomeScreenWidget {
  Widget displayTracks(Future<TrackNameModel?> future, BuildContext context) {
    return FutureBuilder<TrackNameModel?>(
      future: future,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          List<TrackList?> modelList =
              OnlyHasLyrics().lyricsValidator(snapshot);

          return ListView.builder(
            itemCount: modelList.length,
            itemBuilder: (ct, index) {
              String? trackName = modelList[index]?.track.trackName;
              String? artistName = modelList[index]?.track.artistName;
              String? albumName = modelList[index]?.track.albumName;
              String? trackId = modelList[index]?.track.trackId.toString();
              int? hasLyrics = modelList[index]?.track.hasLyrics;
              // trackID = modelList[index]?.track.trackId.toString();

              return DetailedCard().detailHomeCard(context, trackName,
                  artistName, albumName, trackId, hasLyrics);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
