import 'package:credicxo_internship_assignment/api%20services/api_services.dart';
import 'package:credicxo_internship_assignment/api%20services/models/track_name_model.dart';
import 'package:credicxo_internship_assignment/screens/track_details.dart';
import 'package:credicxo_internship_assignment/utils/fade_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import '../utils/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<TrackNameModel?> tracksName;
  ApiServices apiServices = ApiServices();
  String? trackID = '56265';

  @override
  void initState() {
    // TODO: implement initState
    tracksName = apiServices.getTrackName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColorDark,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxScrolled) => [
          const SliverAppBar(
            backgroundColor: Colors.transparent,
            floating: true,
            title: Text(
              "Music Collection",
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          )
        ],
        body: FutureBuilder<TrackNameModel?>(
          future: tracksName,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              int count = 0;
              int? len = snapshot.data?.message.body.trackList.length;
              List<TrackList?> modelList = [];
              for (int? i = 0; i! < len!; i++) {
                int? hasLyrics =
                    snapshot.data?.message.body.trackList[i].track.hasLyrics;
                if (hasLyrics == 1) {
                  count++;
                  modelList.add((snapshot.data?.message.body.trackList[i])!);
                }
              }

              return ListView.builder(
                itemCount: modelList.length,
                itemBuilder: (ct, index) {
                  String? trackName = modelList[index]?.track.trackName;
                  String? artistName = modelList[index]?.track.artistName;
                  String? albumName = modelList[index]?.track.albumName;
                  String? trackId = modelList[index]?.track.trackId.toString();
                  int? hasLyrics = modelList[index]?.track.hasLyrics;
                  trackID = modelList[index]?.track.trackId.toString();

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeRoute(page: TrackDetails(trackId: trackId)),
                      );
                    },
                    child: ListBody(
                      children: [
                        Dismissible(
                          direction: DismissDirection.startToEnd,
                          key: const Key('uniqueKI'),
                          background: Container(
                            color: primaryColor,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Save the lyrics',
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("The Lyrics has been saved"),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: cardColorbgColorDark,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 1, //spread radius
                                      blurRadius: 7, // blur radius
                                      offset: Offset(0, 1),
                                      color: primaryColor)
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Album :",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColorLight
                                                    .withOpacity(0.7)),
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
                                          const Divider(
                                            color: primaryColorDark,
                                          ),
                                          // const Text(
                                          //   "Example :",
                                          //   style: TextStyle(
                                          //       fontSize: 18,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          // Text(
                                          //   "example",
                                          //   maxLines: 7,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: TextStyle(
                                          //       height: 1.5,
                                          //       fontSize: 16,
                                          //       color: Colors.grey[1000],
                                          //       fontWeight: FontWeight.w400),
                                          // ),
                                          RawChip(
                                            elevation: 1,
                                            shadowColor: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.6),
                                            avatar: const Icon(
                                              Icons.save_alt_outlined,
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.20),
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("The Lyrics is saved"),
                                              ));
                                            },
                                            label: const Text(
                                              'Save Lyrics',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              print('No data');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
