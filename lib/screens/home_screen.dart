import 'package:credicxo_internship_assignment/api%20services/api_services.dart';
import 'package:credicxo_internship_assignment/api%20services/models/track_name_model.dart';
import 'package:credicxo_internship_assignment/screens/favorites_screen.dart';
import 'package:credicxo_internship_assignment/screens/track_details.dart';
import 'package:credicxo_internship_assignment/utils/fade_route.dart';
import 'package:credicxo_internship_assignment/widgets/detailed_track_card.dart';
import 'package:credicxo_internship_assignment/widgets/home_screen_widget.dart';
import 'package:credicxo_internship_assignment/widgets/lyrics_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/check_internet.dart';
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
  String appBarTitle = "Music Collection";
  String? trackID;

  @override
  void initState() {
    tracksName = apiServices.getTrackName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColorDark,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(FadeRoute(page: const FavoritesScreen()));
                  },
                  icon: const Icon(Icons.favorite))
            ],
            backgroundColor: Colors.transparent,
            floating: true,
            title: Text(
              appBarTitle,
              style: const TextStyle(fontSize: 20),
            ),
            centerTitle: true,
          )
        ],
        body: HomeScreenWidget().displayTracks(tracksName, context),
      ),
    );
  }
}
