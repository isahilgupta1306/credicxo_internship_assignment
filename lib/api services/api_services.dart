import 'dart:async';
import 'dart:convert';
import 'package:credicxo_internship_assignment/api%20services/models/lyrics_model.dart';
import 'package:credicxo_internship_assignment/api%20services/models/track_details_model.dart';
import 'package:credicxo_internship_assignment/api%20services/models/track_name_model.dart';
import 'package:credicxo_internship_assignment/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String urlA =
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$api_key";

  Future<TrackNameModel?> getTrackName() async {
    TrackNameModel? trackNameModel;
    http.Response response = await http.get(Uri.parse(urlA));

    try {
      if (response.statusCode == 200) {
        //if req suceeds
        var jsonData = json.decode(response.body);
        trackNameModel = TrackNameModel.fromJson(jsonData);

        return trackNameModel;
      }
    } catch (Exception) {
      return trackNameModel;
    }
  }

  Future<TrackDetailsModel?> getTrackDetails(String? trackId) async {
    String urlB =
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=${trackId}&apikey=${api_key}";
    TrackDetailsModel? trackDetailModel;
    http.Response response = await http.get(Uri.parse(urlB));

    try {
      if (response.statusCode == 200) {
        //if req suceeds
        var jsonData = json.decode(response.body);
        trackDetailModel = TrackDetailsModel.fromJson(jsonData);

        return trackDetailModel;
      }
    } catch (Exception) {
      return trackDetailModel;
    }
  }

  Future<LyricsModel?> getLyrics(String? trackId) async {
    String urlC =
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${trackId}&apikey=${api_key}";
    LyricsModel? lyricsModel;
    http.Response response = await http.get(Uri.parse(urlC));

    try {
      if (response.statusCode == 200) {
        //if req suceeds
        var jsonData = json.decode(response.body);
        lyricsModel = LyricsModel.fromJson(jsonData);

        return lyricsModel;
      }
    } catch (Exception) {
      return lyricsModel;
    }
  }
}
