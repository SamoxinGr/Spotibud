import 'package:flutter/material.dart';
import 'package:spotibud/src/pages/cubit/lastNews/lastNews_cubit.dart';
import 'package:spotibud/src/models/followed_artists.dart';

Widget lastNewsWidget(
    lastNews item, BuildContext context, lastNewsLoadedState state) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
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
          leading: Image(
            image: NetworkImage(item.images),
          ),
          title: Text(
            "${item.name}",
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Inter",
              color: Colors.white70,
            ),
          ),
          subtitle: Text(
            "${item.author}",
            style: TextStyle(
                color: Colors.white70,
                fontFamily: "Inter",
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ),
  );
}
