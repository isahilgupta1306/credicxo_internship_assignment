import 'package:credicxo_internship_assignment/api%20services/models/track_name_model.dart';
import 'package:flutter/cupertino.dart';

class OnlyHasLyrics {
  List<TrackList?> lyricsValidator(AsyncSnapshot snapshot) {
    int? len = snapshot.data?.message.body.trackList.length;
    List<TrackList?> data = [];
    for (int? i = 0; i! < len!; i++) {
      int? hasLyrics = snapshot.data?.message.body.trackList[i].track.hasLyrics;
      if (hasLyrics == 1) {
        data.add((snapshot.data?.message.body.trackList[i])!);
      }
    }
    return data;
  }
}
