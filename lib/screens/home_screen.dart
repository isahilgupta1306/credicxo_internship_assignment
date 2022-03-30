import 'package:credicxo_internship_assignment/api%20services/api_services.dart';
import 'package:credicxo_internship_assignment/api%20services/models/track_name_model.dart';
import 'package:credicxo_internship_assignment/screens/favorites_screen.dart';
import 'package:credicxo_internship_assignment/utils/fade_route.dart';
import 'package:credicxo_internship_assignment/widgets/home_screen_widget.dart';

import 'package:flutter/material.dart';
import 'dart:async';


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
