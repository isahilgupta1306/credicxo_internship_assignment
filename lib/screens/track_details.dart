import 'package:credicxo_internship_assignment/api%20services/api_services.dart';
import 'package:credicxo_internship_assignment/api%20services/models/lyrics_model.dart';
import 'package:credicxo_internship_assignment/api%20services/models/track_details_model.dart';
import 'package:credicxo_internship_assignment/main.dart';
import 'package:credicxo_internship_assignment/utils/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class TrackDetails extends StatefulWidget {
  final String? trackId;
  const TrackDetails({Key? key, required this.trackId}) : super(key: key);

  @override
  State<TrackDetails> createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  late Future<TrackDetailsModel?> trackMetaData;
  late Future<LyricsModel?> lyricsModel;

  String? trackName;
  String? albumName;
  String? artistName;
  String? lyrics;
  int? trackRating;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    if (widget.trackId != null) {
      trackMetaData = apiServices.getTrackDetails(widget.trackId);
      lyricsModel = apiServices.getLyrics(widget.trackId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColorDark,
      appBar: AppBar(
        title: const Text('Track Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 22,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FutureBuilder<TrackDetailsModel?>(
              future: trackMetaData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  trackName = snapshot.data?.message.body.track.trackName;
                  albumName = snapshot.data?.message.body.track.albumName;
                  artistName = snapshot.data?.message.body.track.artistName;
                  trackRating = snapshot.data?.message.body.track.trackRating;

                  return ValueListenableBuilder(
                    valueListenable: Hive.box(fav).listenable(),
                    builder: (context, box, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: deviceSize.width * 0.75,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.music_note_outlined,
                                      color: primaryColorLight,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 7),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        trackName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.openSans(
                                            color: white,
                                            fontSize: 25,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (Hive.box(fav)
                                      .containsKey(widget.trackId)) {
                                    Hive.box(fav).delete(widget.trackId);
                                  } else {
                                    Hive.box(fav)
                                        .put(widget.trackId, trackName);
                                  }
                                },
                                icon: Icon(
                                  Hive.box(fav).containsKey(widget.trackId)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border_outlined,
                                  size: 30,
                                  color: white,
                                ),
                              )
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 32, top: 4),
                            child: Text(
                              artistName!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  color: primaryColorLight,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          // Text('From the album'),

                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ratings :',
                                  style: TextStyle(color: white, fontSize: 17),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                RatingBar.builder(
                                  itemSize: 25,
                                  itemBuilder: ((context, index) {
                                    return const Icon(
                                      Icons.star,
                                      color: primaryColorDark,
                                    );
                                  }),
                                  onRatingUpdate: (rating) {},
                                  initialRating: (trackRating! / 10),
                                  ignoreGestures: true,
                                  allowHalfRating: true,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: primaryColorDark.withOpacity(0.6),
                            indent: 45,
                            endIndent: 45,
                            thickness: 1,
                          ),
                          const RawChip(
                            label: Text(
                              'Lyrics',
                              style: TextStyle(color: white),
                            ),
                            avatar: Icon(
                              Icons.arrow_drop_down,
                              color: white,
                            ),
                            backgroundColor: primaryColorDark,
                            labelPadding: EdgeInsets.only(left: 5, right: 10),
                          ),
                          FutureBuilder<LyricsModel?>(
                            future: lyricsModel,
                            builder: (ct, snapshot) {
                              if (snapshot.hasData) {
                                lyrics = snapshot
                                    .data?.message.body.lyrics.lyricsBody;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 25, bottom: 15),
                                  child: Text(
                                    lyrics!,
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      color: white.withOpacity(0.80),
                                    ),
                                  ),
                                );
                              }
                              return const Center(
                                child: Text(
                                  'Loading Lyrics...',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  );
                }
                return const Text('Loading Data..');
              },
            ),
          ]),
        ),
      ),
    );
  }
}
