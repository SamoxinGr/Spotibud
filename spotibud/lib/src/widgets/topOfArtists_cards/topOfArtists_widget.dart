import 'package:flutter/material.dart';
import 'package:spotibud/src/pages/cubit/topOfArtists/topOfArtists_cubit.dart';
import 'package:spotibud/src/models/top_of_artists.dart';

Widget topOfArtistsWidget(
    topOfArtists item, BuildContext context, topOfArtistsLoadedState state) {
  final double width = MediaQuery.of(context).size.width;
  return Card(
    color: Colors.grey[900],
    margin: EdgeInsets.all(10),
    elevation: 7,
    shape: RoundedRectangleBorder(
        //side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    shadowColor: Colors.grey[700],
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          minLeadingWidth: width / 10,
          minVerticalPadding: 20,
          leading: CircleAvatar(
              radius: 30, backgroundImage: NetworkImage(item.images)),
          title: Text(
            "${item.name}",
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Inter",
              color: Colors.white70,
            ),
          ),
        ),
      ],
    ),
  );
}
